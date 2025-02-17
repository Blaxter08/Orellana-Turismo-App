const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.enviarNotificacionEvento = functions.firestore
  .document("eventos/{eventoId}")
  .onUpdate(async (change, context) => {
    const eventoAntes = change.before.data();
    const eventoDespues = change.after.data();

    // Solo enviamos la notificación si isActive cambió de false a true
    if (!eventoAntes.isActive && eventoDespues.isActive) {
      const mensaje = {
        notification: {
          title: "Nuevo Evento Disponible 🎉",
          body: `¡${eventoDespues.nombre} ha sido activado!`,
        },
        topic: "eventos", // Suscribimos a todos los usuarios a este topic
      };

      await admin.messaging().send(mensaje);
      console.log("Notificación enviada a eventos");
    }
  });

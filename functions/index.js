const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.onEventChange = functions.firestore
  .document("events/{eventId}")
  .onWrite(async (change, context) => {
    const before = change.before.exists ? change.before.data() : null;
    const after = change.after.exists ? change.after.data() : null;

    // Verifica si el evento fue activado
    if (!before?.isActive && after?.isActive) {
      const payload = {
        notification: {
          title: "Nuevo Evento Activo",
          body: `¡${after.title} está disponible ahora!`,
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
        topic: "events",
      };

      try {
        await admin.messaging().send(payload);
        console.log("Notificación enviada para el evento:", after.title);
      } catch (error) {
        console.error("Error al enviar la notificación:", error);
      }
    }
  });

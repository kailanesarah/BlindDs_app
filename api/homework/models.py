from django.db import models
import uuid
from users.models import CustomUser


class HomeworkModel(models.Model):
    """
    Model para app de homework.
    """

    atv_id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    atv_code = models.IntegerField(unique=True, blank=True, null=True)
    atv_name = models.CharField(max_length=30)
    atv_description = models.CharField(max_length=255, blank=True, null=True)
    atv_created_at = models.DateTimeField(auto_now_add=True)
    atv_updated_at = models.DateTimeField(auto_now=True)
    user = models.ForeignKey(
        CustomUser, on_delete=models.CASCADE, related_name="homeworks"
    )

    def save(self, *args, **kwargs):
        if not self.atv_code:
            self.atv_code = int(str(uuid.uuid4().int)[:6])
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.atv_name} ({self.atv_code})"

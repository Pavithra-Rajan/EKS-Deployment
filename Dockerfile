FROM python:3.9-slim

WORKDIR /app 

COPY . /app 

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000
# ... (Assuming previous Dockerfile instructions like FROM, WORKDIR, COPY)

# Create a non-root user and group named 'appuser' and 'appgroup'
# The --system flag creates a system user and group, suitable for applications.
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Ensure the application directory and its contents are owned by the non-root user.
# This prevents permission errors when the 'appuser' tries to access the files.
# (Assuming '/app' is the WORKDIR where 'app.py' resides. Adjust if your WORKDIR is different.)
RUN chown -R appuser:appgroup /app

# Switch to the non-root user. All subsequent instructions (like CMD, ENTRYPOINT)
# will be executed as 'appuser' instead of 'root'.
USER appuser
EXPOSE 5000
CMD ["python", "app.py"]
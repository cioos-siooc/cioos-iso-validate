FROM python:3
WORKDIR /repo
COPY . .
RUN bash -c "sh download_schema_files.sh && pip install . && python -m cioos_iso_validate sample_records/valid.xml"

class Test{
final String testStudy = 
'''
[
    {
      "PID": "MS0001",
      "PNAME": "Anonymous",
      "MODALITY": "CR",
      "STUDYDESC": "Chest PA",
      "STUDYDATE": 20210310,
      "REPORTSTATUS": 3,
      "SERIESCNT": 1,
      "IMAGECNT": 1,
      "EXAMSTATUS": 1
    },
    {
      "PID": "MS0010",
      "PNAME": "Anonymous",
      "MODALITY": "MR",
      "STUDYDESC": "SKULL",
      "STUDYDATE": 20160822,
      "REPORTSTATUS": 3,
      "SERIESCNT": 6,
      "IMAGECNT": 270,
      "EXAMSTATUS": 1
    },
    {
      "PID": "MS0014",
      "PNAME": "Anonymous",
      "MODALITY": "XA",
      "STUDYDESC": "Diagnostic arteriography, TFCA",
      "STUDYDATE": 20161025,
      "REPORTSTATUS": 5,
      "SERIESCNT": 6,
      "IMAGECNT": 13,
      "EXAMSTATUS": 1
    },
    {
      "PID": "MS0006",
      "PNAME": "Anonymous",
      "MODALITY": "DR",
      "STUDYDESC": "Ankle(RT) - Mortise",
      "STUDYDATE": 20170824,
      "REPORTSTATUS": 3,
      "SERIESCNT": 1,
      "IMAGECNT": 4,
      "EXAMSTATUS": 1
    },
    {
      "PID": "MS0005",
      "PNAME": "Anonymous",
      "MODALITY": "CT",
      "STUDYDESC": "BRAIN",
      "STUDYDATE": 20180905,
      "REPORTSTATUS": 3,
      "SERIESCNT": 3,
      "IMAGECNT": 186,
      "EXAMSTATUS": 1
    },
    {
      "PID": "MS0002",
      "PNAME": "Anonymous",
      "MODALITY": "CR",
      "STUDYDESC": "clavicle B(ap) lordotic",
      "STUDYDATE": 20200318,
      "REPORTSTATUS": 6,
      "SERIESCNT": 2,
      "IMAGECNT": 2,
      "EXAMSTATUS": 1
    },
    {
      "PID": "TEST-0207",
      "PNAME": "TEST-0207",
      "MODALITY": "MR",
      "STUDYDESC": "********",
      "STUDYDATE": 20230207,
      "REPORTSTATUS": 5,
      "SERIESCNT": 50,
      "IMAGECNT": 5128,
      "EXAMSTATUS": 1
    },
    {
      "PID": "14162",
      "PNAME": "HONG GIL DONG",
      "MODALITY": "CT",
      "STUDYDESC": "CT BRAIN",
      "STUDYDATE": 20230404,
      "REPORTSTATUS": 5,
      "SERIESCNT": 6,
      "IMAGECNT": 136,
      "EXAMSTATUS": 1
    },
    {
      "PID": "17192",
      "PNAME": "강감찬",
      "MODALITY": "CR",
      "STUDYDESC": "Pelvis AP",
      "STUDYDATE": 20230319,
      "REPORTSTATUS": 5,
      "SERIESCNT": 1,
      "IMAGECNT": 1,
      "EXAMSTATUS": 1
    },
    {
      "PID": "17192",
      "PNAME": "강감찬",
      "MODALITY": "CR",
      "STUDYDESC": "Femur AP Lat (R)",
      "STUDYDATE": 20230319,
      "REPORTSTATUS": 6,
      "SERIESCNT": 1,
      "IMAGECNT": 3,
      "EXAMSTATUS": 1
    },
    {
      "PID": "17192",
      "PNAME": "강감찬",
      "MODALITY": "CT",
      "STUDYDESC": "CT BRAIN",
      "STUDYDATE": 20230319,
      "REPORTSTATUS": 6,
      "SERIESCNT": 7,
      "IMAGECNT": 173,
      "EXAMSTATUS": 1
    },
    {
      "PID": "PATIENT_ID",
      "PNAME": "PATIENT",
      "MODALITY": "CT",
      "STUDYDESC": "Brain CT (no contrast)",
      "STUDYDATE": 20221115,
      "REPORTSTATUS": 3,
      "SERIESCNT": 2,
      "IMAGECNT": 92,
      "EXAMSTATUS": 1
    },
    {
      "PID": "MS0001",
      "PNAME": "Anonymous",
      "MODALITY": "CR",
      "STUDYDESC": "HC/Mammography",
      "STUDYDATE": 20181010,
      "REPORTSTATUS": 3,
      "SERIESCNT": 1,
      "IMAGECNT": 4,
      "EXAMSTATUS": 1
    },
    {
      "PID": "MS0004",
      "PNAME": "Anonymous",
      "MODALITY": "CT",
      "STUDYDESC": "Abdomen^001_Abdomen_Q5Child (Child)",
      "STUDYDATE": 20181230,
      "REPORTSTATUS": 3,
      "SERIESCNT": 5,
      "IMAGECNT": 329,
      "EXAMSTATUS": 1
    },
    {
      "PID": "anonymous",
      "PNAME": "anonymous^anonymous",
      "MODALITY": "CR",
      "STUDYDESC": null,
      "STUDYDATE": 20170405,
      "REPORTSTATUS": 3,
      "SERIESCNT": 1,
      "IMAGECNT": 1,
      "EXAMSTATUS": 1
    },
    {
      "PID": "snuh_312338348",
      "PNAME": "Unknown",
      "MODALITY": "CR",
      "STUDYDESC": null,
      "STUDYDATE": 20211013,
      "REPORTSTATUS": 3,
      "SERIESCNT": 1,
      "IMAGECNT": 1,
      "EXAMSTATUS": 1
    },
    {
      "PID": "snuh_332076675",
      "PNAME": "Unknown",
      "MODALITY": "CR",
      "STUDYDESC": null,
      "STUDYDATE": 20211013,
      "REPORTSTATUS": 3,
      "SERIESCNT": 1,
      "IMAGECNT": 1,
      "EXAMSTATUS": 1
    },
    {
      "PID": "MS0012",
      "PNAME": "Anonymous",
      "MODALITY": "US",
      "STUDYDESC": "(Advanced) Transthoracic Echocardiography",
      "STUDYDATE": 20181018,
      "REPORTSTATUS": 3,
      "SERIESCNT": 1,
      "IMAGECNT": 40,
      "EXAMSTATUS": 1
    },
    {
      "PID": "MS0011",
      "PNAME": "Anonymous",
      "MODALITY": "US",
      "STUDYDESC": "SKULL",
      "STUDYDATE": 20190625,
      "REPORTSTATUS": 5,
      "SERIESCNT": 1,
      "IMAGECNT": 2,
      "EXAMSTATUS": 1
    },
    {
      "PID": "MS0003",
      "PNAME": "Anonymous",
      "MODALITY": "CR",
      "STUDYDESC": "Mammo.(R)Cr-Ca",
      "STUDYDATE": 20200404,
      "REPORTSTATUS": 3,
      "SERIESCNT": 1,
      "IMAGECNT": 3,
      "EXAMSTATUS": 1
    },
    {
      "PID": "snuh_295345400",
      "PNAME": "Unknown",
      "MODALITY": "CR",
      "STUDYDESC": null,
      "STUDYDATE": 20211013,
      "REPORTSTATUS": 3,
      "SERIESCNT": 1,
      "IMAGECNT": 1,
      "EXAMSTATUS": 1
    },
    {
      "PID": "MS0013",
      "PNAME": "Anonymous",
      "MODALITY": "XA",
      "STUDYDESC": "HEART",
      "STUDYDATE": 20181115,
      "REPORTSTATUS": 5,
      "SERIESCNT": 2,
      "IMAGECNT": 19,
      "EXAMSTATUS": 1
    },
    {
      "PID": "MS0007",
      "PNAME": "Anonymous",
      "MODALITY": "ES",
      "STUDYDESC": "(암)결장경검사",
      "STUDYDATE": 20190123,
      "REPORTSTATUS": 3,
      "SERIESCNT": 1,
      "IMAGECNT": 46,
      "EXAMSTATUS": 1
    },
    {
      "PID": "MS0009",
      "PNAME": "Anonymous",
      "MODALITY": "MR",
      "STUDYDESC": "L-Spine MRI",
      "STUDYDATE": 20190314,
      "REPORTSTATUS": 3,
      "SERIESCNT": 6,
      "IMAGECNT": 110,
      "EXAMSTATUS": 1
    },
    {
      "PID": "MS0008",
      "PNAME": "Anonymous",
      "MODALITY": "ES",
      "STUDYDESC": "SLEEPING ENDOSCOPY",
      "STUDYDATE": 20190130,
      "REPORTSTATUS": 3,
      "SERIESCNT": 1,
      "IMAGECNT": 48,
      "EXAMSTATUS": 1
    },
    {
      "PID": "TEST-27-2",
      "PNAME": "TEST-27-2",
      "MODALITY": "SC",
      "STUDYDESC": "Brain CT (no contrast)",
      "STUDYDATE": 20221227,
      "REPORTSTATUS": 3,
      "SERIESCNT": 1,
      "IMAGECNT": 46,
      "EXAMSTATUS": 1
    },
    {
      "PID": "TEST-27-3",
      "PNAME": "TEST-27-3",
      "MODALITY": "SC",
      "STUDYDESC": "Brain CT (no contrast)",
      "STUDYDATE": 20221227,
      "REPORTSTATUS": 3,
      "SERIESCNT": 1,
      "IMAGECNT": 46,
      "EXAMSTATUS": 1
    }
  ]
''';
}
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sdtc="urn:hl7-org:sdtc" xmlns:n1="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <xsl:output method="html" indent="yes" version="4.01" encoding="ISO-8859-1" doctype-system="http://www.w3.org/TR/html4/strict.dtd" doctype-public="-//W3C//DTD HTML 4.01//EN"/>
  <!-- global variable title -->
  <xsl:param name="a1"></xsl:param>
  <xsl:param name="a2"></xsl:param>
  <xsl:param name="a3"></xsl:param>
  <xsl:param name="a4"></xsl:param>
  <xsl:param name="a5"></xsl:param>
  <xsl:param name="a6"></xsl:param>
  <xsl:param name="a7"></xsl:param>
  <xsl:param name="a8"></xsl:param>
  <xsl:param name="a9"></xsl:param>
  <xsl:param name="a10"></xsl:param>
  <xsl:param name="a11"></xsl:param>
  <xsl:param name="a12"></xsl:param>
  <xsl:param name="a13"></xsl:param>
  <xsl:param name="a14"></xsl:param>
  <xsl:param name="a15"></xsl:param>
  <xsl:param name="a16"></xsl:param>
  <xsl:param name="a17"></xsl:param>
  <xsl:param name="a18"></xsl:param>
  <xsl:param name="a19"></xsl:param>
  <xsl:param name="a20"></xsl:param>
  <xsl:param name="a21"></xsl:param>
  <xsl:param name="a22"></xsl:param>
  <xsl:param name="a23"></xsl:param>
  <xsl:param name="a24"></xsl:param>
  <!--<xsl:param name="a1">referrals-0</xsl:param>
  <xsl:param name="a2">medications-0</xsl:param>
  <xsl:param name="a3">care plan-0</xsl:param>
  <xsl:param name="a4">chief complaint-0</xsl:param>
  <xsl:param name="a5">functional status-0</xsl:param>
  <xsl:param name="a6">family history-0</xsl:param>
  <xsl:param name="a7">social history-1</xsl:param>
  <xsl:param name="a8">immunizations-0</xsl:param>
  <xsl:param name="a9">encounter diagnosis-0</xsl:param>
  <xsl:param name="a10">medical equipment-0</xsl:param>
  <xsl:param name="a11">results-1</xsl:param>
  <xsl:param name="a12">meds administered-0</xsl:param>
  <xsl:param name="a13">vital signs-0</xsl:param>
  <xsl:param name="a14"></xsl:param>
  <xsl:param name="a15">problems-0</xsl:param>
  <xsl:param name="a16">health concerns-0</xsl:param>
  <xsl:param name="a17">allergies-0</xsl:param>
  <xsl:param name="a18">goals-0</xsl:param>
  <xsl:param name="a19">procedures-0</xsl:param>
  <xsl:param name="a20">assesments-0</xsl:param>
  <xsl:param name="a21">discharge meds-0</xsl:param>
  <xsl:param name="a22">admission diagnosis-0</xsl:param>
  <xsl:param name="a23">admission meds-0</xsl:param>
  <xsl:param name="a24">mental status-0</xsl:param>
  -->

  <xsl:variable name="s1">
    <xsl:choose>
      <xsl:when test="contains($a1, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a1, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a1, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a1, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a1, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a1, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a1, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a1, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a1, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a1, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a1, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a1, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a1, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a1, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a1, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a1, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a1, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a1, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a1, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a1, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a1, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a1, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a1, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a1, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s2">
    <xsl:choose>
      <xsl:when test="contains($a2, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a2, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a2, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a2, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a2, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a2, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a2, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a2, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a2, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a2, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a2, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a2, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a2, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a2, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a2, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a2, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a2, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a2, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a2, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a2, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a2, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a2, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a2, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a2, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s3">
    <xsl:choose>
      <xsl:when test="contains($a3, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a3, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a3, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a3, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a3, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a3, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a3, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a3, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a3, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a3, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a3, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a3, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a3, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a3, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a3, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a3, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a3, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a3, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a3, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a3, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a3, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a3, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a3, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a3, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s4">
    <xsl:choose>
      <xsl:when test="contains($a4, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a4, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a4, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a4, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a4, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a4, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a4, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a4, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a4, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a4, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a4, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a4, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a4, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a4, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a4, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a4, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a4, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a4, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a4, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a4, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a4, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a4, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a4, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a4, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s5">
    <xsl:choose>
      <xsl:when test="contains($a5, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a5, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a5, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a5, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a5, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a5, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a5, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a5, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a5, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a5, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a5, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a5, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a5, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a5, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a5, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a5, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a5, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a5, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a5, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a5, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a5, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a5, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a5, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a5, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s6">
    <xsl:choose>
      <xsl:when test="contains($a6, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a6, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a6, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a6, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a6, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a6, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a6, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a6, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a6, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a6, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a6, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a6, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a6, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a6, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a6, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a6, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a6, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a6, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a6, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a6, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a6, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a6, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a6, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a6, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s7">
    <xsl:choose>
      <xsl:when test="contains($a7, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a7, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a7, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a7, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a7, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a7, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a7, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a7, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a7, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a7, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a7, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a7, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a7, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a7, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a7, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a7, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a7, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a7, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a7, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a7, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a7, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a7, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a7, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a7, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s8">
    <xsl:choose>
      <xsl:when test="contains($a8, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a8, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a8, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a8, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a8, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a8, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a8, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a8, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a8, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a8, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a8, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a8, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a8, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a8, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a8, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a8, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a8, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a8, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a8, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a8, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a8, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a8, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a8, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a8, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s9">
    <xsl:choose>
      <xsl:when test="contains($a9, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a9, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a9, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a9, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a9, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a9, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a9, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a9, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a9, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a9, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a9, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a9, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a9, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a9, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a9, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a9, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a9, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a9, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a9, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a9, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a9, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a9, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a9, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a9, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s10">
    <xsl:choose>
      <xsl:when test="contains($a10, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a10, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a10, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a10, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a10, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a10, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a10, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a10, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a10, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a10, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a10, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a10, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a10, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a10, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a10, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a10, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a10, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a10, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a10, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a10, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a10, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a10, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a10, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a10, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s11">
    <xsl:choose>
      <xsl:when test="contains($a11, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a11, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a11, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a11, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a11, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a11, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a11, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a11, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a11, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a11, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a11, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a11, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a11, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a11, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a11, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a11, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a11, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a11, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a11, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a11, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a11, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a11, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a11, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a11, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s12">
    <xsl:choose>
      <xsl:when test="contains($a12, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a12, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a12, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a12, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a12, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a12, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a12, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a12, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a12, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a12, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a12, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a12, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a12, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a12, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a12, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a12, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a12, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a12, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a12, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a12, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a12, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a12, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a12, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a12, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s13">
    <xsl:choose>
      <xsl:when test="contains($a13, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a13, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a13, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a13, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a13, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a13, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a13, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a13, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a13, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a13, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a13, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a13, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a13, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a13, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a13, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a13, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a13, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a13, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a13, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a13, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a13, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a13, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a13, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a13, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s14">
    <xsl:choose>
      <xsl:when test="contains($a14, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a14, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a14, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a14, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a14, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a14, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a14, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a14, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a14, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a14, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a14, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a14, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a14, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a14, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a14, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a14, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a14, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a14, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a14, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a14, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a14, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a14, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a14, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a14, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s15">
    <xsl:choose>
      <xsl:when test="contains($a15, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a15, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a15, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a15, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a15, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a15, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a15, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a15, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a15, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a15, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a15, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a15, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a15, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a15, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a15, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a15, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a15, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a15, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a15, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a15, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a15, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a15, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a15, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a15, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s16">
    <xsl:choose>
      <xsl:when test="contains($a16, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a16, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a16, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a16, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a16, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a16, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a16, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a16, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a16, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a16, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a16, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a16, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a16, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a16, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a16, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a16, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a16, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a16, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a16, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a16, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a16, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a16, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a16, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a16, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s17">
    <xsl:choose>
      <xsl:when test="contains($a17, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a17, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a17, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a17, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a17, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a17, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a17, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a17, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a17, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a17, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a17, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a17, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a17, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a17, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a17, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a17, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a17, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a17, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a17, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a17, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a17, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a17, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a17, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a17, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s18">
    <xsl:choose>
      <xsl:when test="contains($a18, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a18, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a18, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a18, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a18, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a18, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a18, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a18, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a18, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a18, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a18, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a18, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a18, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a18, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a18, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a18, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a18, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a18, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a18, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a18, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a18, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a18, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a18, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s19">
    <xsl:choose>
      <xsl:when test="contains($a19, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a19, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a19, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a19, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a19, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a19, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a19, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a19, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a19, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a19, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a19, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a19, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a19, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a19, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a19, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a19, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a19, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a19, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a19, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a19, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a19, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a19, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a19, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a19, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s20">
    <xsl:choose>
      <xsl:when test="contains($a20, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a20, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a20, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a20, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a20, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a20, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a20, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a20, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a20, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a20, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a20, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a20, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a20, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a20, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a20, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a20, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a20, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a20, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a20, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a20, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a20, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a20, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a20, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a20, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s21">
    <xsl:choose>
      <xsl:when test="contains($a21, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a21, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a21, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a21, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a21, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a21, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a21, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a21, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a21, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a21, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a21, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a21, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a21, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a21, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a21, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a21, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a21, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a21, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a21, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a21, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a21, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a21, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a21, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a21, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s22">
    <xsl:choose>
      <xsl:when test="contains($a22, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a22, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a22, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a22, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a22, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a22, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a22, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a22, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a22, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a22, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a22, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a22, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a22, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a22, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a22, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a22, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a22, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a22, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a22, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a22, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a22, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a22, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a22, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a22, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="s23">
    <xsl:choose>
      <xsl:when test="contains($a23, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a23, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a23, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a23, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a23, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a23, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a23, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a23, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a23, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a23, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a23, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a23, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a23, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a23, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a23, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a23, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a23, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a23, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a23, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a23, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a23, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a23, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a23, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a23, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="s24">
    <xsl:choose>
      <xsl:when test="contains($a24, 'referrals')">1.3.6.1.4.1.19376.1.5.3.1.3.1</xsl:when>
      <xsl:when test="contains($a24, 'medications')">2.16.840.1.113883.10.20.22.2.1.1</xsl:when>
      <xsl:when test="contains($a24, 'care plan')">2.16.840.1.113883.10.20.22.2.10</xsl:when>
      <xsl:when test="contains($a24, 'chief complaint')">2.16.840.1.113883.10.20.22.2.13</xsl:when>
      <xsl:when test="contains($a24, 'functional status')">2.16.840.1.113883.10.20.22.2.14</xsl:when>
      <xsl:when test="contains($a24, 'family history')">2.16.840.1.113883.10.20.22.2.15</xsl:when>
      <xsl:when test="contains($a24, 'social history')">2.16.840.1.113883.10.20.22.2.17</xsl:when>
      <xsl:when test="contains($a24, 'immunizations')">2.16.840.1.113883.10.20.22.2.2.1</xsl:when>
      <xsl:when test="contains($a24, 'encounter diagnosis')">2.16.840.1.113883.10.20.22.2.22.1</xsl:when>
      <xsl:when test="contains($a24, 'medical equipment')">2.16.840.1.113883.10.20.22.2.23</xsl:when>
      <xsl:when test="contains($a24, 'results')">2.16.840.1.113883.10.20.22.2.3.1</xsl:when>
      <xsl:when test="contains($a24, 'meds administered')">2.16.840.1.113883.10.20.22.2.38</xsl:when>
      <xsl:when test="contains($a24, 'vital signs')">2.16.840.1.113883.10.20.22.2.4.1</xsl:when>
      <xsl:when test="contains($a24, 'discharge instructions')">2.16.840.1.113883.10.20.22.2.41</xsl:when>
      <xsl:when test="contains($a24, 'problems')">2.16.840.1.113883.10.20.22.2.5.1</xsl:when>
      <xsl:when test="contains($a24, 'health concerns')">2.16.840.1.113883.10.20.22.2.58</xsl:when>
      <xsl:when test="contains($a24, 'allergies')">2.16.840.1.113883.10.20.22.2.6.1</xsl:when>
      <xsl:when test="contains($a24, 'goals')">2.16.840.1.113883.10.20.22.2.60</xsl:when>
      <xsl:when test="contains($a24, 'procedures')">2.16.840.1.113883.10.20.22.2.7.1</xsl:when>
      <xsl:when test="contains($a24, 'assesments')">2.16.840.1.113883.10.20.22.2.8</xsl:when>
      <xsl:when test="contains($a24, 'discharge meds')">2.16.840.1.113883.10.20.22.2.11.1</xsl:when>
      <xsl:when test="contains($a24, 'admission diagnosis')">2.16.840.1.113883.10.20.22.2.43</xsl:when>
      <xsl:when test="contains($a24, 'admission meds')">2.16.840.1.113883.10.20.22.2.44</xsl:when>
      <xsl:when test="contains($a24, 'mental status')">2.16.840.1.113883.10.20.22.2.56</xsl:when>
    </xsl:choose>
  </xsl:variable>


  <xsl:variable name="s1-visible">
    <xsl:choose>
      <xsl:when test="contains($a1, '-0')">false</xsl:when>
      <xsl:when test="contains($a1, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s2-visible">
    <xsl:choose>
      <xsl:when test="contains($a2, '-0')">false</xsl:when>
      <xsl:when test="contains($a2, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s3-visible">
    <xsl:choose>
      <xsl:when test="contains($a3, '-0')">false</xsl:when>
      <xsl:when test="contains($a3, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s4-visible">
    <xsl:choose>
      <xsl:when test="contains($a4, '-0')">false</xsl:when>
      <xsl:when test="contains($a4, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s5-visible">
    <xsl:choose>
      <xsl:when test="contains($a5, '-0')">false</xsl:when>
      <xsl:when test="contains($a5, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s6-visible">
    <xsl:choose>
      <xsl:when test="contains($a6, '-0')">false</xsl:when>
      <xsl:when test="contains($a6, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s7-visible">
    <xsl:choose>
      <xsl:when test="contains($a7, '-0')">false</xsl:when>
      <xsl:when test="contains($a7, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s8-visible">
    <xsl:choose>
      <xsl:when test="contains($a8, '-0')">false</xsl:when>
      <xsl:when test="contains($a8, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s9-visible">
    <xsl:choose>
      <xsl:when test="contains($a9, '-0')">false</xsl:when>
      <xsl:when test="contains($a9, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s10-visible">
    <xsl:choose>
      <xsl:when test="contains($a10, '-0')">false</xsl:when>
      <xsl:when test="contains($a10, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s11-visible">
    <xsl:choose>
      <xsl:when test="contains($a11, '-0')">false</xsl:when>
      <xsl:when test="contains($a11, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s12-visible">
    <xsl:choose>
      <xsl:when test="contains($a12, '-0')">false</xsl:when>
      <xsl:when test="contains($a12, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s13-visible">
    <xsl:choose>
      <xsl:when test="contains($a13, '-0')">false</xsl:when>
      <xsl:when test="contains($a13, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s14-visible">
    <xsl:choose>
      <xsl:when test="contains($a14, '-0')">false</xsl:when>
      <xsl:when test="contains($a14, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s15-visible">
    <xsl:choose>
      <xsl:when test="contains($a15, '-0')">false</xsl:when>
      <xsl:when test="contains($a15, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s16-visible">
    <xsl:choose>
      <xsl:when test="contains($a16, '-0')">false</xsl:when>
      <xsl:when test="contains($a16, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s17-visible">
    <xsl:choose>
      <xsl:when test="contains($a17, '-0')">false</xsl:when>
      <xsl:when test="contains($a17, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s18-visible">
    <xsl:choose>
      <xsl:when test="contains($a18, '-0')">false</xsl:when>
      <xsl:when test="contains($a18, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s19-visible">
    <xsl:choose>
      <xsl:when test="contains($a19, '-0')">false</xsl:when>
      <xsl:when test="contains($a19, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s20-visible">
    <xsl:choose>
      <xsl:when test="contains($a20, '-0')">false</xsl:when>
      <xsl:when test="contains($a20, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="s21-visible">
    <xsl:choose>
      <xsl:when test="contains($a21, '-0')">false</xsl:when>
      <xsl:when test="contains($a21, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="s22-visible">
    <xsl:choose>
      <xsl:when test="contains($a22, '-0')">false</xsl:when>
      <xsl:when test="contains($a22, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="s23-visible">
    <xsl:choose>
      <xsl:when test="contains($a23, '-0')">false</xsl:when>
      <xsl:when test="contains($a23, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="s24-visible">
    <xsl:choose>
      <xsl:when test="contains($a24, '-0')">false</xsl:when>
      <xsl:when test="contains($a24, '-1')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="title">
    <xsl:choose>
      <xsl:when test="string-length(/n1:ClinicalDocument/n1:title)  &gt;= 1">
        <xsl:value-of select="/n1:ClinicalDocument/n1:title"/>
      </xsl:when>
      <xsl:when test="/n1:ClinicalDocument/n1:code/@displayName">
        <xsl:value-of select="/n1:ClinicalDocument/n1:code/@displayName"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>Clinical Document</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <!-- Main -->

  <!-- produce browser rendered, human readable clinical document	-->
  <xsl:template match="n1:ClinicalDocument">
    <style type="text/css">
      <xsl:text>
            body {
	            color: #003366;
	            background-color: #FFFFFF;
	            font-family: Verdana, Tahoma, sans-serif;
	            font-size: 11px;
            }

            a {
	            color: #003366;
	            background-color: #FFFFFF;
            }

            h1 {
	            font-size: 12pt;
	            font-weight: bold;
            }

            h2 {
	            font-size: 11pt;
	            font-weight: bold;
            }

            h3 {
	            font-size: 10pt;
	            font-weight: bold;
            }

            h4 {
	            font-size: 8pt;
	            font-weight: bold;
            }

            div {
	            width: 80%;
            }

            table {
	            line-height: 10pt;
	            width: 80%;
            }

            tr {
	            background-color: #ccccff;
            }

            td {
	            padding: 0.1cm 0.2cm;
	            vertical-align: top;
            }

            .h1center {
	            font-size: 12pt;
	            font-weight: bold;
	            text-align: center;
	            width: 80%;
            }

            .header_table{
	            border: 1pt inset #00008b;
            }

            .narr_table {
	            width: 100%;
            }

            .narr_tr {
	            background-color: #ffffcc;
            }

            .narr_th {
	            background-color: #ffd700;
            }

            .td_label{
	            font-weight: bold;
	            color: #000000;
            }

					</xsl:text>
    </style>
    <script>
      <xsl:text>
            function toggle_visibility(id) {

               var e =document.getElementById(id);
   

               if(e.style.display == 'none')
                {
                  e.style.display = 'block';
                }
               else
               {
                  e.style.display = 'none';
                }
            }
          </xsl:text>


    </script>
    <!-- START display top portion of clinical document -->
    <xsl:call-template name="recordTarget"/>
    <xsl:call-template name="documentGeneral"/>
    <xsl:call-template name="documentationOf"/>
    <xsl:call-template name="author"/>
    <!-- END display top portion of clinical document -->
    <!-- START display bottom portion of clinical document -->
    <xsl:call-template name="componentof"/>
    <xsl:call-template name="custodian"/>
    <xsl:call-template name="participant"/>
    <xsl:call-template name="dataEnterer"/>
    <xsl:call-template name="authenticator"/>
    <xsl:call-template name="informant"/>
    <xsl:call-template name="informationRecipient"/>
    <xsl:call-template name="legalAuthenticator"/>
    <!-- END display bottom portion of clinical document -->

    <!-- produce table of contents -->
    <xsl:call-template name="make-tableofcontents"/>
    <hr align="left" color="teal" size="2" width="80%"/>
    <!-- produce human readable document content -->
    <xsl:apply-templates select="n1:component/n1:structuredBody|n1:component/n1:nonXMLBody"/>
    <br/>
    <hr align="left" color="teal" size="2" width="80%"/>
    <br/>
  </xsl:template>
  <!-- generate table of contents -->
  <xsl:template match="/">
    <html lang="en" xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
        <meta charset="utf-8" />
        <title>CCDA View</title>
      </head>
      <body>
        <xsl:apply-templates select="n1:ClinicalDocument"/>
      </body>
    </html>
  </xsl:template>
  <xsl:template name="make-tableofcontents">
    <h2>
      <a name="toc">Table of Contents</a>
    </h2>
    <ul>

      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s1]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s2]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s3]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s4]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s5]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s6]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s7]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s8]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s9]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s10]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s11]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s12]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s13]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s14]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s15]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s16]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s17]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s18]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s19]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s20]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s21]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s22]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s23]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[@root=$s24]/../n1:title"></xsl:apply-templates>
      <xsl:apply-templates select="//n1:component/n1:section/n1:templateId[(@root !=$s1) and (@root !=$s2) and (@root !=$s3) and (@root !=$s4) and (@root !=$s5) and (@root !=$s6) and (@root !=$s7) and (@root !=$s8) and (@root !=$s9) and (@root !=$s10) and (@root !=$s11) and (@root !=$s12) and (@root !=$s13) and (@root !=$s14) and (@root !=$s15) and (@root !=$s16) and (@root !=$s17) and (@root !=$s18) and (@root !=$s19) and (@root !=$s20) and (@root !=$s21) and (@root !=$s22) and (@root !=$s23) and (@root !=$s24)]/../n1:title"></xsl:apply-templates>
    </ul>
  </xsl:template>
  <!-- header elements -->
  <xsl:template match="n1:title">
    <li>
      <a href="#{generate-id(.)}">
        <xsl:value-of select="."/>
      </a>
    </li>
  </xsl:template>
  <xsl:template name="documentGeneral">
    <table class="header_table">
      <tbody>
        <tr>
          <td width="20%" bgcolor="#3399ff">
            <span class="td_label">
              <xsl:text>Document Id</xsl:text>
            </span>
          </td>
          <td width="80%">
            <xsl:call-template name="show-id">
              <xsl:with-param name="id" select="n1:id"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr>
          <td width="20%" bgcolor="#3399ff">
            <span class="td_label">
              <xsl:text>Document Created:</xsl:text>
            </span>
          </td>
          <td width="80%">
            <xsl:call-template name="show-time">
              <xsl:with-param name="datetime" select="n1:effectiveTime"/>
            </xsl:call-template>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>
  <!-- confidentiality -->
  <xsl:template name="confidentiality">
    <table class="header_table">
      <tbody>
        <td width="20%" bgcolor="#3399ff">
          <xsl:text>Confidentiality</xsl:text>
        </td>
        <td width="80%">
          <xsl:choose>
            <xsl:when test="n1:confidentialityCode/@code  = &apos;N&apos;">
              <xsl:text>Normal</xsl:text>
            </xsl:when>
            <xsl:when test="n1:confidentialityCode/@code  = &apos;R&apos;">
              <xsl:text>Restricted</xsl:text>
            </xsl:when>
            <xsl:when test="n1:confidentialityCode/@code  = &apos;V&apos;">
              <xsl:text>Very restricted</xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:if test="n1:confidentialityCode/n1:originalText">
            <xsl:text> </xsl:text>
            <xsl:value-of select="n1:confidentialityCode/n1:originalText"/>
          </xsl:if>
        </td>
      </tbody>
    </table>
  </xsl:template>
  <!-- author -->
  <xsl:template name="author">
    <table class="header_table">
      <tbody>
        <xsl:for-each select="n1:author/n1:assignedAuthor">
          <tr>
            <td width="20%" bgcolor="#3399ff">
              <span class="td_label">
                <xsl:text>Author</xsl:text>
              </span>
            </td>
            <td width="80%">
              <xsl:choose>
                <xsl:when test="n1:assignedPerson/n1:name">
                  <xsl:call-template name="show-name">
                    <xsl:with-param name="name" select="n1:assignedPerson/n1:name"/>
                  </xsl:call-template>
                  <xsl:if test="n1:representedOrganization">
                    <xsl:text>, </xsl:text>
                    <xsl:call-template name="show-name">
                      <xsl:with-param name="name" select="n1:representedOrganization/n1:name"/>
                    </xsl:call-template>
                  </xsl:if>
                </xsl:when>
                <xsl:when test="n1:assignedAuthoringDevice/n1:softwareName">
                  <xsl:value-of select="n1:assignedAuthoringDevice/n1:softwareName"/>
                </xsl:when>
                <xsl:when test="n1:representedOrganization">
                  <xsl:call-template name="show-name">
                    <xsl:with-param name="name" select="n1:representedOrganization/n1:name"/>
                  </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:for-each select="n1:id">
                    <xsl:call-template name="show-id"/>
                    <br/>
                  </xsl:for-each>
                </xsl:otherwise>
              </xsl:choose>
            </td>
          </tr>
          <xsl:if test="n1:addr | n1:telecom">
            <tr>
              <td bgcolor="#3399ff">
                <span class="td_label">
                  <xsl:text>Contact info</xsl:text>
                </span>
              </td>
              <td>
                <xsl:call-template name="show-contactInfo">
                  <xsl:with-param name="contact" select="."/>
                </xsl:call-template>
              </td>
            </tr>
          </xsl:if>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>
  <!-- 	authenticator -->
  <xsl:template name="authenticator">
    <xsl:if test="n1:authenticator">
      <table class="header_table">
        <tbody>
          <tr>
            <xsl:for-each select="n1:authenticator">
              <tr>
                <td width="20%" bgcolor="#3399ff">
                  <span class="td_label">
                    <xsl:text>Signed </xsl:text>
                  </span>
                </td>
                <td width="80%">
                  <xsl:call-template name="show-name">
                    <xsl:with-param name="name" select="n1:assignedEntity/n1:assignedPerson/n1:name"/>
                  </xsl:call-template>
                  <xsl:text> at </xsl:text>
                  <xsl:call-template name="show-time">
                    <xsl:with-param name="date" select="n1:time"/>
                  </xsl:call-template>
                </td>
              </tr>
              <xsl:if test="n1:assignedEntity/n1:addr | n1:assignedEntity/n1:telecom">
                <tr>
                  <td bgcolor="#3399ff">
                    <span class="td_label">
                      <xsl:text>Contact info</xsl:text>
                    </span>
                  </td>
                  <td width="80%">
                    <xsl:call-template name="show-contactInfo">
                      <xsl:with-param name="contact" select="n1:assignedEntity"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </xsl:if>
            </xsl:for-each>
          </tr>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  <!-- legalAuthenticator -->
  <xsl:template name="legalAuthenticator">
    <xsl:if test="n1:legalAuthenticator">
      <table class="header_table">
        <tbody>
          <tr>
            <td width="20%" bgcolor="#3399ff">
              <span class="td_label">
                <xsl:text>Legal authenticator</xsl:text>
              </span>
            </td>
            <td width="80%">
              <xsl:call-template name="show-assignedEntity">
                <xsl:with-param name="asgnEntity" select="n1:legalAuthenticator/n1:assignedEntity"/>
              </xsl:call-template>
              <xsl:text> </xsl:text>
              <xsl:call-template name="show-sig">
                <xsl:with-param name="sig" select="n1:legalAuthenticator/n1:signatureCode"/>
              </xsl:call-template>
              <xsl:if test="n1:legalAuthenticator/n1:time/@value">
                <xsl:text> at </xsl:text>
                <xsl:call-template name="show-time">
                  <xsl:with-param name="datetime" select="n1:legalAuthenticator/n1:time"/>
                </xsl:call-template>
              </xsl:if>
            </td>
          </tr>
          <xsl:if test="n1:legalAuthenticator/n1:assignedEntity/n1:addr | n1:legalAuthenticator/n1:assignedEntity/n1:telecom">
            <tr>
              <td bgcolor="#3399ff">
                <span class="td_label">
                  <xsl:text>Contact info</xsl:text>
                </span>
              </td>
              <td>
                <xsl:call-template name="show-contactInfo">
                  <xsl:with-param name="contact" select="n1:legalAuthenticator/n1:assignedEntity"/>
                </xsl:call-template>
              </td>
            </tr>
          </xsl:if>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  <!-- dataEnterer -->
  <xsl:template name="dataEnterer">
    <xsl:if test="n1:dataEnterer">
      <table class="header_table">
        <tbody>
          <tr>
            <td width="20%" bgcolor="#3399ff">
              <span class="td_label">
                <xsl:text>Entered by</xsl:text>
              </span>
            </td>
            <td width="80%">
              <xsl:call-template name="show-assignedEntity">
                <xsl:with-param name="asgnEntity" select="n1:dataEnterer/n1:assignedEntity"/>
              </xsl:call-template>
            </td>
          </tr>
          <xsl:if test="n1:dataEnterer/n1:assignedEntity/n1:addr | n1:dataEnterer/n1:assignedEntity/n1:telecom">
            <tr>
              <td bgcolor="#3399ff">
                <span class="td_label">
                  <xsl:text>Contact info</xsl:text>
                </span>
              </td>
              <td>
                <xsl:call-template name="show-contactInfo">
                  <xsl:with-param name="contact" select="n1:dataEnterer/n1:assignedEntity"/>
                </xsl:call-template>
              </td>
            </tr>
          </xsl:if>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  <!-- componentOf -->
  <xsl:template name="componentof">
    <xsl:if test="n1:componentOf">
      <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:componentOf/n1:encompassingEncounter">
            <xsl:if test="n1:location/n1:healthCareFacility">
              <tr>
                <td width="20%" bgcolor="#3399ff">
                  <span class="td_label">
                    <xsl:text>Encounter Location</xsl:text>
                  </span>
                </td>
                <td width="80%">
                  <xsl:choose>
                    <xsl:when test="n1:location/n1:healthCareFacility/n1:location/n1:name">
                      <xsl:call-template name="show-name">
                        <xsl:with-param name="name" select="n1:location/n1:healthCareFacility/n1:location/n1:name"/>
                      </xsl:call-template>
                      <xsl:for-each select="n1:location/n1:healthCareFacility/n1:serviceProviderOrganization/n1:name">
                        <xsl:text> of </xsl:text>
                        <xsl:call-template name="show-name">
                          <xsl:with-param name="name" select="n1:location/n1:healthCareFacility/n1:serviceProviderOrganization/n1:name"/>
                        </xsl:call-template>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="n1:location/n1:healthCareFacility/n1:code">
                      <xsl:call-template name="show-code">
                        <xsl:with-param name="code" select="n1:location/n1:healthCareFacility/n1:code"/>
                      </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:if test="n1:location/n1:healthCareFacility/n1:id">
                        <xsl:text>id: </xsl:text>
                        <xsl:for-each select="n1:location/n1:healthCareFacility/n1:id">
                          <xsl:call-template name="show-id">
                            <xsl:with-param name="id" select="."/>
                          </xsl:call-template>
                        </xsl:for-each>
                      </xsl:if>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="n1:responsibleParty">
              <tr>
                <td bgcolor="#3399ff">
                  <span class="td_label">
                    <xsl:text>Responsible party</xsl:text>
                  </span>
                </td>
                <td width="80%">
                  <xsl:call-template name="show-assignedEntity">
                    <xsl:with-param name="asgnEntity" select="n1:responsibleParty/n1:assignedEntity"/>
                  </xsl:call-template>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="n1:responsibleParty/n1:assignedEntity/n1:addr | n1:responsibleParty/n1:assignedEntity/n1:telecom">
              <tr>
                <td bgcolor="#3399ff">
                  <span class="td_label">
                    <xsl:text>Contact info</xsl:text>
                  </span>
                </td>
                <td>
                  <xsl:call-template name="show-contactInfo">
                    <xsl:with-param name="contact" select="n1:responsibleParty/n1:assignedEntity"/>
                  </xsl:call-template>
                </td>
              </tr>
            </xsl:if>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  <!-- custodian -->
  <xsl:template name="custodian">
    <table class="header_table">
      <tbody>
        <tr>
          <td width="20%" bgcolor="#3399ff">
            <span class="td_label">
              <xsl:text>Document maintained by</xsl:text>
            </span>
          </td>
          <td width="80%">
            <xsl:choose>
              <xsl:when test="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:name">
                <xsl:call-template name="show-name">
                  <xsl:with-param name="name" select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:name"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:id">
                  <xsl:call-template name="show-id"/>
                  <xsl:if test="position()!=last()">
                    <br/>
                  </xsl:if>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
        <xsl:if test="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:addr | 						n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:telecom">
          <tr>
            <td bgcolor="#3399ff">
              <span class="td_label">
                <xsl:text>Contact info</xsl:text>
              </span>
            </td>
            <td width="80%">
              <xsl:call-template name="show-contactInfo">
                <xsl:with-param name="contact" select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization"/>
              </xsl:call-template>
            </td>
          </tr>
        </xsl:if>
      </tbody>
    </table>
  </xsl:template>
  <!-- documentationOf -->
  <xsl:template name="documentationOf">
    <xsl:if test="n1:documentationOf">
      <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:documentationOf">
            <xsl:if test="n1:serviceEvent/@classCode and n1:serviceEvent/n1:code">
              <xsl:variable name="displayName">
                <xsl:call-template name="show-actClassCode">
                  <xsl:with-param name="clsCode" select="n1:serviceEvent/@classCode"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:if test="$displayName">
                <tr>
                  <td width="20%" bgcolor="#3399ff">
                    <span class="td_label">
                      <xsl:call-template name="firstCharCaseUp">
                        <xsl:with-param name="data" select="$displayName"/>
                      </xsl:call-template>
                    </span>
                  </td>
                  <td width="80%" colspan="3">
                    <xsl:call-template name="show-code">
                      <xsl:with-param name="code" select="n1:serviceEvent/n1:code"/>
                    </xsl:call-template>
                    <xsl:if test="n1:serviceEvent/n1:effectiveTime">
                      <xsl:choose>
                        <xsl:when test="n1:serviceEvent/n1:effectiveTime/@value">
                          <xsl:text>&#160;at&#160;</xsl:text>
                          <xsl:call-template name="show-time">
                            <xsl:with-param name="datetime" select="n1:serviceEvent/n1:effectiveTime"/>
                          </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="n1:serviceEvent/n1:effectiveTime/n1:low">
                          <xsl:text>&#160;from&#160;</xsl:text>
                          <xsl:call-template name="show-time">
                            <xsl:with-param name="datetime" select="n1:serviceEvent/n1:effectiveTime/n1:low"/>
                          </xsl:call-template>
                          <xsl:if test="n1:serviceEvent/n1:effectiveTime/n1:high">
                            <xsl:text> to </xsl:text>
                            <xsl:call-template name="show-time">
                              <xsl:with-param name="datetime" select="n1:serviceEvent/n1:effectiveTime/n1:high"/>
                            </xsl:call-template>
                          </xsl:if>
                        </xsl:when>
                      </xsl:choose>
                    </xsl:if>
                  </td>
                </tr>
              </xsl:if>
            </xsl:if>
            <xsl:for-each select="n1:serviceEvent/n1:performer">
              <xsl:variable name="displayName">
                <xsl:call-template name="show-participationType">
                  <xsl:with-param name="ptype" select="@typeCode"/>
                </xsl:call-template>
                <xsl:text> </xsl:text>
                <xsl:if test="n1:functionCode/@code">
                  <xsl:text>(</xsl:text>
                  <xsl:call-template name="show-participationFunction">
                    <xsl:with-param name="pFunction" select="n1:functionCode/@code"/>
                  </xsl:call-template>
                  <xsl:text>)</xsl:text>
                </xsl:if>
              </xsl:variable>
              <tr>
                <td width="20%" bgcolor="#3399ff">
                  <span class="td_label">
                    <xsl:call-template name="firstCharCaseUp">
                      <xsl:with-param name="data" select="$displayName"/>
                    </xsl:call-template>
                  </span>
                </td>
                <td width="80%" colspan="3">
                  <xsl:call-template name="show-assignedEntity">
                    <xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
                  </xsl:call-template>
                </td>
              </tr>
              <tr>
                <td bgcolor="#3399ff">
                  <span class="td_label">
                    <xsl:text>Contact info</xsl:text>
                  </span>
                </td>
                <td width="80%">
                  <xsl:call-template name="show-contactInfo">
                    <xsl:with-param name="contact" select="n1:assignedEntity"/>
                  </xsl:call-template>
                </td>
              </tr>
            </xsl:for-each>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  <!-- inFulfillmentOf -->
  <xsl:template name="inFulfillmentOf">
    <xsl:if test="n1:infulfillmentOf">
      <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:inFulfillmentOf">
            <tr>
              <td width="20%" bgcolor="#3399ff">
                <span class="td_label">
                  <xsl:text>In fulfillment of</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:for-each select="n1:order">
                  <xsl:for-each select="n1:id">
                    <xsl:call-template name="show-id"/>
                  </xsl:for-each>
                  <xsl:for-each select="n1:code">
                    <xsl:text>&#160;</xsl:text>
                    <xsl:call-template name="show-code">
                      <xsl:with-param name="code" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="n1:priorityCode">
                    <xsl:text>&#160;</xsl:text>
                    <xsl:call-template name="show-code">
                      <xsl:with-param name="code" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  <!-- informant -->
  <xsl:template name="informant">
    <xsl:if test="n1:informant">
      <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:informant">
            <tr>
              <td width="20%" bgcolor="#3399ff">
                <span class="td_label">
                  <xsl:text>Informant</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:if test="n1:assignedEntity">
                  <xsl:call-template name="show-assignedEntity">
                    <xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
                  </xsl:call-template>
                </xsl:if>
                <xsl:if test="n1:relatedEntity">
                  <xsl:call-template name="show-relatedEntity">
                    <xsl:with-param name="relatedEntity" select="n1:relatedEntity"/>
                  </xsl:call-template>
                </xsl:if>
              </td>
            </tr>
            <xsl:choose>
              <xsl:when test="n1:assignedEntity/n1:addr | n1:assignedEntity/n1:telecom">
                <tr>
                  <td bgcolor="#3399ff">
                    <span class="td_label">
                      <xsl:text>Contact info</xsl:text>
                    </span>
                  </td>
                  <td>
                    <xsl:if test="n1:assignedEntity">
                      <xsl:call-template name="show-contactInfo">
                        <xsl:with-param name="contact" select="n1:assignedEntity"/>
                      </xsl:call-template>
                    </xsl:if>
                  </td>
                </tr>
              </xsl:when>
              <xsl:when test="n1:relatedEntity/n1:addr | n1:relatedEntity/n1:telecom">
                <tr>
                  <td bgcolor="#3399ff">
                    <span class="td_label">
                      <xsl:text>Contact info</xsl:text>
                    </span>
                  </td>
                  <td>
                    <xsl:if test="n1:relatedEntity">
                      <xsl:call-template name="show-contactInfo">
                        <xsl:with-param name="contact" select="n1:relatedEntity"/>
                      </xsl:call-template>
                    </xsl:if>
                  </td>
                </tr>
              </xsl:when>
            </xsl:choose>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  <!-- informantionRecipient -->
  <xsl:template name="informationRecipient">
    <xsl:if test="n1:informationRecipient">
      <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:informationRecipient">
            <tr>
              <td width="20%" bgcolor="#3399ff">
                <span class="td_label">
                  <xsl:text>Information recipient:</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:choose>
                  <xsl:when test="n1:intendedRecipient/n1:informationRecipient/n1:name">
                    <xsl:for-each select="n1:intendedRecipient/n1:informationRecipient">
                      <xsl:call-template name="show-name">
                        <xsl:with-param name="name" select="n1:name"/>
                      </xsl:call-template>
                      <xsl:if test="position() != last()">
                        <br/>
                      </xsl:if>
                    </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:for-each select="n1:intendedRecipient">
                      <xsl:for-each select="n1:id">
                        <xsl:call-template name="show-id"/>
                      </xsl:for-each>
                      <xsl:if test="position() != last()">
                        <br/>
                      </xsl:if>
                      <br/>
                    </xsl:for-each>
                  </xsl:otherwise>
                </xsl:choose>
              </td>
            </tr>
            <xsl:if test="n1:intendedRecipient/n1:addr | n1:intendedRecipient/n1:telecom">
              <tr>
                <td bgcolor="#3399ff">
                  <span class="td_label">
                    <xsl:text>Contact info</xsl:text>
                  </span>
                </td>
                <td>
                  <xsl:call-template name="show-contactInfo">
                    <xsl:with-param name="contact" select="n1:intendedRecipient"/>
                  </xsl:call-template>
                </td>
              </tr>
            </xsl:if>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  <!-- participant -->
  <xsl:template name="participant">
    <xsl:if test="n1:participant">
      <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:participant">
            <tr>
              <td width="20%" bgcolor="#3399ff">
                <xsl:variable name="participtRole">
                  <xsl:call-template name="translateRoleAssoCode">
                    <xsl:with-param name="classCode" select="n1:associatedEntity/@classCode"/>
                    <xsl:with-param name="code" select="n1:associatedEntity/n1:code"/>
                  </xsl:call-template>
                </xsl:variable>
                <xsl:choose>
                  <xsl:when test="$participtRole">
                    <span class="td_label">
                      <xsl:call-template name="firstCharCaseUp">
                        <xsl:with-param name="data" select="$participtRole"/>
                      </xsl:call-template>
                    </span>
                  </xsl:when>
                  <xsl:otherwise>
                    <span class="td_label">
                      <xsl:text>Participant</xsl:text>
                    </span>
                  </xsl:otherwise>
                </xsl:choose>
              </td>
              <td width="80%">
                <xsl:if test="n1:functionCode">
                  <xsl:call-template name="show-code">
                    <xsl:with-param name="code" select="n1:functionCode"/>
                  </xsl:call-template>
                </xsl:if>
                <xsl:call-template name="show-associatedEntity">
                  <xsl:with-param name="assoEntity" select="n1:associatedEntity"/>
                </xsl:call-template>
                <xsl:if test="n1:time">
                  <xsl:if test="n1:time/n1:low">
                    <xsl:text> from </xsl:text>
                    <xsl:call-template name="show-time">
                      <xsl:with-param name="datetime" select="n1:time/n1:low"/>
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="n1:time/n1:high">
                    <xsl:text> to </xsl:text>
                    <xsl:call-template name="show-time">
                      <xsl:with-param name="datetime" select="n1:time/n1:high"/>
                    </xsl:call-template>
                  </xsl:if>
                </xsl:if>
                <xsl:if test="position() != last()">
                  <br/>
                </xsl:if>
              </td>
            </tr>
            <xsl:if test="n1:associatedEntity/n1:addr | n1:associatedEntity/n1:telecom">
              <tr>
                <td bgcolor="#3399ff">
                  <span class="td_label">
                    <xsl:text>Contact info</xsl:text>
                  </span>
                </td>
                <td>
                  <xsl:call-template name="show-contactInfo">
                    <xsl:with-param name="contact" select="n1:associatedEntity"/>
                  </xsl:call-template>
                </td>
              </tr>
            </xsl:if>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  <!-- recordTarget -->
  <xsl:template name="recordTarget">
    <table class="header_table">
      <tbody>
        <xsl:for-each select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole">
          <xsl:if test="not(n1:id/@nullFlavor)">
            <tr>
              <td width="20%" bgcolor="#3399ff">
                <span class="td_label">
                  <xsl:text>Patient</xsl:text>
                </span>
              </td>
              <td colspan="3">
                <xsl:for-each select="n1:patient/n1:name">
                  <xsl:choose>
                    <xsl:when test="./n1:given[@qualifier]">
                      <br></br>
                      Previous Name:
                      <xsl:call-template name="show-name">
                        <xsl:with-param name="name" select="."/>
                      </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                      Name:
                      <xsl:call-template name="show-name">
                        <xsl:with-param name="name" select="."/>
                      </xsl:call-template>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
                <!--<xsl:call-template name="show-name">
                  <xsl:with-param name="name" select="n1:patient/n1:name"/>
                </xsl:call-template>-->
              </td>
            </tr>
            <tr>
              <td width="20%" bgcolor="#3399ff">
                <span class="td_label">
                  <xsl:text>Date of birth</xsl:text>
                </span>
              </td>
              <td width="30%">
                <xsl:call-template name="show-time">
                  <xsl:with-param name="datetime" select="n1:patient/n1:birthTime"/>
                </xsl:call-template>
              </td>
              <td width="15%" bgcolor="#3399ff">
                <span class="td_label">
                  <xsl:text>Sex</xsl:text>
                </span>
              </td>
              <td>
                <xsl:for-each select="n1:patient/n1:administrativeGenderCode">
                  <xsl:call-template name="show-gender"/>
                </xsl:for-each>
              </td>
            </tr>
            <xsl:if test="n1:patient/n1:raceCode | (n1:patient/n1:ethnicGroupCode)">
              <tr>
                <td width="20%" bgcolor="#3399ff">
                  <span class="td_label">
                    <xsl:text>Race</xsl:text>
                  </span>
                </td>
                <td width="30%">
                  <xsl:choose>
                    <xsl:when test="n1:patient/n1:raceCode">
                      Race:
                      <xsl:for-each select="n1:patient/n1:raceCode[1]">
                        <xsl:call-template name="show-race-ethnicity"/>
                      </xsl:for-each>
                      <xsl:for-each select="n1:patient/sdtc:raceCode[1]">
                        Granular Race:
                        <xsl:call-template name="show-race-ethnicity"/>
                      </xsl:for-each>
                      <xsl:for-each select="n1:patient/sdtc:raceCode[2]">
                        Race2:
                        <xsl:call-template name="show-race-ethnicity"/>
                      </xsl:for-each>
                      <xsl:for-each select="n1:patient/sdtc:raceCode[3]">
                        Granular Race2:
                        <xsl:call-template name="show-race-ethnicity"/>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>Information not available</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
                <td width="15%" bgcolor="#3399ff">
                  <span class="td_label">
                    <xsl:text>Ethnicity</xsl:text>
                  </span>
                </td>
                <td width="30%">
                  <xsl:choose>
                    <xsl:when test="n1:patient/n1:ethnicGroupCode">
                      Ethnicity:
                      <xsl:for-each select="n1:patient/n1:ethnicGroupCode">
                        <xsl:call-template name="show-race-ethnicity"/>
                      </xsl:for-each>
                      <xsl:for-each select="n1:patient/sdtc:ethnicGroupCode[1]">
                        Granular Ethnicity:
                        <xsl:call-template name="show-race-ethnicity"/>
                      </xsl:for-each>

                      <xsl:for-each select="n1:patient/sdtc:ethnicGroupCode[2]">
                        Ethnicity2:
                        <xsl:call-template name="show-race-ethnicity"/>
                      </xsl:for-each>
                      <xsl:for-each select="n1:patient/sdtc:ethnicGroupCode[3]">
                        Granular Ethnicity2:
                        <xsl:call-template name="show-race-ethnicity"/>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>Information not available</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>
            </xsl:if>
            <tr>
              <td width="20%" bgcolor="#3399ff">
                <span class="td_label">
                  <xsl:text>Preferred Language</xsl:text>
                </span>
              </td>
              <td width="30%">
                <xsl:apply-templates select="n1:patient/n1:languageCommunication"/>
                ( <xsl:value-of select ="n1:patient/n1:languageCommunication/n1:languageCode/@code"></xsl:value-of> )
              </td>
              <td width="15%" bgcolor="#3399ff">
              </td>
              <td>
              </td>

            </tr>

            <tr>
              <td bgcolor="#3399ff">
                <span class="td_label">
                  <xsl:text>Contact info</xsl:text>
                </span>
              </td>
              <td>
                <xsl:call-template name="show-contactInfo">
                  <xsl:with-param name="contact" select="."/>
                </xsl:call-template>
              </td>
              <td bgcolor="#3399ff">
                <span class="td_label">
                  <xsl:text>Patient IDs</xsl:text>
                </span>
              </td>
              <td>
                <xsl:for-each select="n1:id">
                  <xsl:call-template name="show-id"/>
                  <br/>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:if>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>
  <!-- relatedDocument -->
  <xsl:template name="relatedDocument">
    <xsl:if test="n1:relatedDocument">
      <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:relatedDocument">
            <tr>
              <td width="20%" bgcolor="#3399ff">
                <span class="td_label">
                  <xsl:text>Related document</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:for-each select="n1:parentDocument">
                  <xsl:for-each select="n1:id">
                    <xsl:call-template name="show-id"/>
                    <br/>
                  </xsl:for-each>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  <!-- authorization (consent) -->
  <xsl:template name="authorization">
    <xsl:if test="n1:authorization">
      <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:authorization">
            <tr>
              <td width="20%" bgcolor="#3399ff">
                <span class="td_label">
                  <xsl:text>Consent</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:choose>
                  <xsl:when test="n1:consent/n1:code">
                    <xsl:call-template name="show-code">
                      <xsl:with-param name="code" select="n1:consent/n1:code"/>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:call-template name="show-code">
                      <xsl:with-param name="code" select="n1:consent/n1:statusCode"/>
                    </xsl:call-template>
                  </xsl:otherwise>
                </xsl:choose>
                <br/>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  <!-- setAndVersion -->
  <xsl:template name="setAndVersion">
    <xsl:if test="n1:setId and n1:versionNumber">
      <table class="header_table">
        <tbody>
          <tr>
            <td width="20%">
              <xsl:text>SetId and Version</xsl:text>
            </td>
            <td colspan="3">
              <xsl:text>SetId: </xsl:text>
              <xsl:call-template name="show-id">
                <xsl:with-param name="id" select="n1:setId"/>
              </xsl:call-template>
              <xsl:text>  Version: </xsl:text>
              <xsl:value-of select="n1:versionNumber/@value"/>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  <!-- show StructuredBody 	-->
  <xsl:template match="n1:component/n1:structuredBody">
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s1]/..">
      <xsl:with-param name="visible" select="$s1-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s2]/..">
      <xsl:with-param name="visible" select="$s2-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s3]/..">
      <xsl:with-param name="visible" select="$s3-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s4]/..">
      <xsl:with-param name="visible" select="$s4-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s5]/..">
      <xsl:with-param name="visible" select="$s5-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s6]/..">
      <xsl:with-param name="visible" select="$s6-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s7]/..">
      <xsl:with-param name="visible" select="$s7-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s8]/..">
      <xsl:with-param name="visible" select="$s8-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s9]/..">
      <xsl:with-param name="visible" select="$s9-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s10]/..">
      <xsl:with-param name="visible" select="$s10-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s11]/..">
      <xsl:with-param name="visible" select="$s11-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s12]/..">
      <xsl:with-param name="visible" select="$s12-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s13]/..">
      <xsl:with-param name="visible" select="$s13-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s14]/..">
      <xsl:with-param name="visible" select="$s14-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s15]/..">
      <xsl:with-param name="visible" select="$s15-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s16]/..">
      <xsl:with-param name="visible" select="$s16-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s17]/..">
      <xsl:with-param name="visible" select="$s17-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s18]/..">
      <xsl:with-param name="visible" select="$s18-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s19]/..">
      <xsl:with-param name="visible" select="$s19-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s20]/..">
      <xsl:with-param name="visible" select="$s20-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s21]/..">
      <xsl:with-param name="visible" select="$s21-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s22]/..">
      <xsl:with-param name="visible" select="$s22-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s23]/..">
      <xsl:with-param name="visible" select="$s23-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[@root=$s24]/..">
      <xsl:with-param name="visible" select="$s24-visible"></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="n1:component/n1:section/n1:templateId[(@root !=$s1) and (@root !=$s2) and (@root !=$s3) and (@root !=$s4) and (@root !=$s5) and (@root !=$s6) and (@root !=$s7) and (@root !=$s8) and (@root !=$s9) and (@root !=$s10) and (@root !=$s11) and (@root !=$s12) and (@root !=$s13) and (@root !=$s14) and (@root !=$s15) and (@root !=$s16) and (@root !=$s17) and (@root !=$s18) and (@root !=$s19) and (@root !=$s20) and (@root !=$s21) and (@root !=$s22) and (@root !=$s23) and (@root !=$s24)]/..">
      <xsl:with-param name="visible" select="true"></xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>
  <!-- show nonXMLBody -->
  <xsl:template match='n1:component/n1:nonXMLBody'>
    <xsl:choose>
      <!-- if there is a reference, use that in an IFRAME -->
      <xsl:when test='n1:text/n1:reference'>
        <IFRAME name='nonXMLBody' id='nonXMLBody' WIDTH='80%' HEIGHT='66%' src='{n1:text/n1:reference/@value}'/>
      </xsl:when>
      <xsl:when test='n1:text/@mediaType="text/plain"'>
        <pre>
          <xsl:value-of select='n1:text/text()'/>
        </pre>
      </xsl:when>
      <xsl:otherwise>
        <CENTER>Cannot display the text</CENTER>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- top level component/section: display title and text,
     and process any nested component/sections
	 -->
  <xsl:template match="n1:section">
    <xsl:param name="visible"/>
    <xsl:call-template name="section-title">
      <xsl:with-param name="title" select="n1:title"/>
    </xsl:call-template>
    <xsl:call-template name="section-author"></xsl:call-template>
    <xsl:call-template name="section-text">
      <xsl:with-param name="title" select="n1:title"/>
      <xsl:with-param name="visible" select="$visible"/>
    </xsl:call-template>
    <xsl:for-each select="n1:component/n1:section">
      <xsl:call-template name="nestedSection">
        <xsl:with-param name="margin" select="2"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>
  <!--<xsl:template name="section">
    <xsl:call-template name="section-title">
      <xsl:with-param name="title" select="n1:title"/>
    </xsl:call-template>
    <xsl:call-template name="section-author"></xsl:call-template>
    <xsl:call-template name="section-text">
      <xsl:with-param name="title" select="n1:title"/>
    </xsl:call-template>
    <xsl:for-each select="n1:component/n1:section">
      <xsl:call-template name="nestedSection">
        <xsl:with-param name="margin" select="2"/>
      </xsl:call-template>
    </xsl:for-each>

  </xsl:template>-->
  <!-- top level section title -->
  <xsl:template name="section-title">
    <xsl:param name="title"/>
    <h3>
      <a href="javascript:toggle_visibility('{generate-id($title)}')">
        <xsl:value-of select="$title"/>
      </a>
    </h3>
  </xsl:template>
  <!-- section author -->
  <xsl:template name="section-author">
    <xsl:if test="count(n1:author)&gt;0">
      <div style="margin-left : 2em;">
        <strong>
          <xsl:text>Section Author: </xsl:text>
        </strong>
        <xsl:for-each select="n1:author/n1:assignedAuthor">
          <xsl:choose>
            <xsl:when test="n1:assignedPerson/n1:name">
              <xsl:call-template name="show-name">
                <xsl:with-param name="name" select="n1:assignedPerson/n1:name"/>
              </xsl:call-template>
              <xsl:if test="n1:representedOrganization">
                <xsl:text>, </xsl:text>
                <xsl:call-template name="show-name">
                  <xsl:with-param name="name" select="n1:representedOrganization/n1:name"/>
                </xsl:call-template>
              </xsl:if>
            </xsl:when>
            <xsl:when test="n1:assignedAuthoringDevice/n1:softwareName">
              <xsl:value-of select="n1:assignedAuthoringDevice/n1:softwareName"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:for-each select="n1:id">
                <xsl:call-template name="show-id"/>
                <br/>
              </xsl:for-each>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
        <br />
      </div>
    </xsl:if>
  </xsl:template>
  <!-- top-level section Text    -->
  <xsl:template name="section-text">
    <xsl:param name="visible"/>
    <div id="{generate-id(n1:title)}" name="{generate-id(n1:title)}" >
      <xsl:if test="$visible = 'true'">
        <xsl:attribute name="style">
          <xsl:text>display:block;</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$visible = 'false'">
        <xsl:attribute name="style">
          <xsl:text>display:none;</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="n1:text" />
    </div>
  </xsl:template>
  <!-- nested component/section -->
  <xsl:template name="nestedSection">
    <xsl:param name="margin" />
    <h4 style="margin-left : {$margin}em;">
      <xsl:value-of select="n1:title"/>
    </h4>
    <div style="margin-left : {$margin}em;">
      <xsl:apply-templates select="n1:text"/>
    </div>
    <xsl:for-each select="n1:component/n1:section">
      <xsl:call-template name="nestedSection">
        <xsl:with-param name="margin" select="2*$margin"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>
  <!--   paragraph  -->
  <xsl:template match="n1:paragraph">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <!--   pre format  -->
  <xsl:template match="n1:pre">
    <pre>
      <xsl:apply-templates/>
    </pre>
  </xsl:template>
  <!--   Content w/ deleted text is hidden -->
  <xsl:template match="n1:content[@revised='delete']"/>
  <!--   content  -->
  <xsl:template match="n1:content">
    <xsl:apply-templates/>
  </xsl:template>
  <!-- line break -->
  <xsl:template match="n1:br">
    <xsl:element name='br'>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <!--   list  -->
  <xsl:template match="n1:list">
    <xsl:if test="n1:caption">
      <p>
        <strong>
          <xsl:apply-templates select="n1:caption"/>
        </strong>
      </p>
    </xsl:if>
    <ul>
      <xsl:for-each select="n1:item">
        <li>
          <xsl:apply-templates/>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>
  <xsl:template match="n1:list[@listType='ordered']">
    <xsl:if test="n1:caption">
      <span style="font-weight:bold; ">
        <xsl:apply-templates select="n1:caption"/>
      </span>
    </xsl:if>
    <ol>
      <xsl:for-each select="n1:item">
        <li>
          <xsl:apply-templates/>
        </li>
      </xsl:for-each>
    </ol>
  </xsl:template>
  <!--   caption  -->
  <xsl:template match="n1:caption">
    <xsl:apply-templates/>
    <xsl:text>: </xsl:text>
  </xsl:template>
  <!--  Tables   -->
  <xsl:template match="n1:table/@*|n1:thead/@*|n1:tfoot/@*|n1:tbody/@*|n1:colgroup/@*|n1:col/@*|n1:tr/@*|n1:th/@*|n1:td/@*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="n1:table">
    <table class="narr_table">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </table>
  </xsl:template>
  <xsl:template match="n1:thead">
    <thead>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </thead>
  </xsl:template>
  <xsl:template match="n1:tfoot">
    <tfoot>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </tfoot>
  </xsl:template>
  <xsl:template match="n1:tbody">
    <tbody>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </tbody>
  </xsl:template>
  <xsl:template match="n1:colgroup">
    <colgroup>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </colgroup>
  </xsl:template>
  <xsl:template match="n1:col">
    <col>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </col>
  </xsl:template>
  <xsl:template match="n1:tr">
    <tr class="narr_tr">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>
  <xsl:template match="n1:th">
    <th class="narr_th">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </th>
  </xsl:template>
  <xsl:template match="n1:td">
    <td>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </td>
  </xsl:template>
  <xsl:template match="n1:table/n1:caption">
    <span style="font-weight:bold; ">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <!--   RenderMultiMedia 
    this currently only handles GIF's and JPEG's.  It could, however,
    be extended by including other image MIME types in the predicate
    and/or by generating <object> or <applet> tag with the correct
    params depending on the media type  @ID  =$imageRef  referencedObject
    -->
  <xsl:template match="n1:renderMultiMedia">
    <xsl:variable name="imageRef" select="@referencedObject"/>
    <xsl:choose>
      <xsl:when test="//n1:regionOfInterest[@ID=$imageRef]">
        <!-- Here is where the Region of Interest image referencing goes -->
        <xsl:if test="//n1:regionOfInterest[@ID=$imageRef]//n1:observationMedia/n1:value[@mediaType='image/gif'           or
          @mediaType='image/jpeg']">
          <br clear="all"/>
          <xsl:element name="img">
            <xsl:attribute name="src">
              <xsl:value-of select="//n1:regionOfInterest[@ID=$imageRef]//n1:observationMedia/n1:value/n1:reference/@value"/>
            </xsl:attribute>
          </xsl:element>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <!-- Here is where the direct MultiMedia image referencing goes -->
        <xsl:if test="//n1:observationMedia[@ID=$imageRef]/n1:value[@mediaType='image/gif' or @mediaType='image/jpeg']">
          <br clear="all"/>
          <xsl:element name="img">
            <xsl:attribute name="src">
              <xsl:value-of select="//n1:observationMedia[@ID=$imageRef]/n1:value/n1:reference/@value"/>
            </xsl:attribute>
          </xsl:element>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--    Stylecode processing   
    Supports Bold, Underline and Italics display
    -->
  <xsl:template match="//n1:*[@styleCode]">
    <xsl:if test="@styleCode='Bold'">
      <xsl:element name="b">
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:if>
    <xsl:if test="@styleCode='Italics'">
      <xsl:element name="i">
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:if>
    <xsl:if test="@styleCode='Underline'">
      <xsl:element name="u">
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:if>
    <xsl:if test="contains(@styleCode,'Bold') and contains(@styleCode,'Italics') and not (contains(@styleCode, 'Underline'))">
      <xsl:element name="b">
        <xsl:element name="i">
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:element>
    </xsl:if>
    <xsl:if test="contains(@styleCode,'Bold') and contains(@styleCode,'Underline') and not (contains(@styleCode, 'Italics'))">
      <xsl:element name="b">
        <xsl:element name="u">
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:element>
    </xsl:if>
    <xsl:if test="contains(@styleCode,'Italics') and contains(@styleCode,'Underline') and not (contains(@styleCode, 'Bold'))">
      <xsl:element name="i">
        <xsl:element name="u">
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:element>
    </xsl:if>
    <xsl:if test="contains(@styleCode,'Italics') and contains(@styleCode,'Underline') and contains(@styleCode, 'Bold')">
      <xsl:element name="b">
        <xsl:element name="i">
          <xsl:element name="u">
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:if>
    <xsl:if test="not (contains(@styleCode,'Italics') or contains(@styleCode,'Underline') or contains(@styleCode, 'Bold'))">
      <xsl:apply-templates/>
    </xsl:if>
  </xsl:template>
  <!--    Superscript or Subscript   -->
  <xsl:template match="n1:sup">
    <xsl:element name="sup">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="n1:sub">
    <xsl:element name="sub">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <!-- show-signature -->
  <xsl:template name="show-sig">
    <xsl:param name="sig"/>
    <xsl:choose>
      <xsl:when test="$sig/@code =&apos;S&apos;">
        <xsl:text>signed</xsl:text>
      </xsl:when>
      <xsl:when test="$sig/@code=&apos;I&apos;">
        <xsl:text>intended</xsl:text>
      </xsl:when>
      <xsl:when test="$sig/@code=&apos;X&apos;">
        <xsl:text>signature required</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!--  show-id -->
  <xsl:template name="show-id">
    <xsl:param name="id"/>
    <xsl:choose>
      <xsl:when test="not($id)">
        <xsl:if test="not(@nullFlavor)">
          <xsl:if test="@extension">
            <xsl:value-of select="@extension"/>
          </xsl:if>
          <xsl:text> </xsl:text>
          <xsl:value-of select="@root"/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="not($id/@nullFlavor)">
          <xsl:if test="$id/@extension">
            <xsl:value-of select="$id/@extension"/>
          </xsl:if>
          <xsl:text> </xsl:text>
          <xsl:value-of select="$id/@root"/>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- show-name  -->
  <xsl:template name="show-name">
    <xsl:param name="name"/>
    <xsl:choose>
      <xsl:when test="$name/n1:family">
        <xsl:if test="$name/n1:prefix">
          <xsl:value-of select="$name/n1:prefix"/>
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:for-each select="$name/n1:given">
          <xsl:text> </xsl:text>
          <xsl:value-of select="."/>
          <xsl:text>  </xsl:text>
        </xsl:for-each>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$name/n1:family"/>
        <xsl:if test="$name/n1:suffix">
          <xsl:text>, </xsl:text>
          <xsl:value-of select="$name/n1:suffix"/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$name"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- show-gender  -->
  <xsl:template name="show-gender">
    <xsl:choose>
      <xsl:when test="@code   = &apos;M&apos;">
        <xsl:text>Male</xsl:text>
      </xsl:when>
      <xsl:when test="@code  = &apos;F&apos;">
        <xsl:text>Female</xsl:text>
      </xsl:when>
      <xsl:when test="@code  = &apos;U&apos;">
        <xsl:text>Undifferentiated</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- show-race-ethnicity  -->
  <xsl:template name="show-race-ethnicity">
    <xsl:choose>
      <xsl:when test="@displayName">
        <xsl:value-of select="@displayName"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="show-noneFlavor">
          <xsl:with-param name="nf" select="@nullFlavor"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test ="@code">
      (<xsl:value-of select="@code"/>)
    </xsl:if>
    <br></br>
  </xsl:template>
  <!-- show-contactInfo -->
  <xsl:template name="show-contactInfo">
    <xsl:param name="contact"/>
    <xsl:for-each select="$contact/n1:addr">
       <xsl:call-template name="show-address">
        <xsl:with-param name="address" select="."/>
      </xsl:call-template>
    </xsl:for-each>
    <br/>
    <xsl:for-each select="$contact/n1:telecom">
      <xsl:call-template name="show-telecom">
        <xsl:with-param name="telecom" select="."/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>
  <!-- show-address -->
  <xsl:template name="show-address">
    <xsl:param name="address"/>
    <xsl:choose>
      <xsl:when test="$address">
        <xsl:if test="$address/@use">
          <xsl:text> </xsl:text>
          <xsl:call-template name="translateAddressCode">
            <xsl:with-param name="code" select="$address/@use"/>
          </xsl:call-template>
          <xsl:text>:</xsl:text>
          <br/>
        </xsl:if>
        <xsl:for-each select="$address/n1:streetAddressLine">
          <xsl:value-of select="."/>
          <br/>
        </xsl:for-each>
        <xsl:if test="$address/n1:streetName">
          <xsl:value-of select="$address/n1:streetName"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="$address/n1:houseNumber"/>
          <br/>
        </xsl:if>
        <xsl:if test="string-length($address/n1:city)>0">
          <xsl:value-of select="$address/n1:city"/>
        </xsl:if>
        <xsl:if test="string-length($address/n1:state)>0">
          <xsl:text>,&#160;</xsl:text>
          <xsl:value-of select="$address/n1:state"/>
        </xsl:if>
        <xsl:if test="string-length($address/n1:postalCode)>0">
          <xsl:text>&#160;</xsl:text>
          <xsl:value-of select="$address/n1:postalCode"/>
        </xsl:if>
        <xsl:if test="string-length($address/n1:country)>0">
          <xsl:text>,&#160;</xsl:text>
          <xsl:value-of select="$address/n1:country"/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>address not available</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <br/>
  </xsl:template>
  <!-- show-telecom -->
  <xsl:template name="show-telecom">
    <xsl:param name="telecom"/>
    <xsl:choose>
      <xsl:when test="$telecom">
        <xsl:variable name="type">
          <xsl:text>tel</xsl:text>
        </xsl:variable>
        <xsl:variable name="value" select="$telecom/@value"/>
        <xsl:if test="$type">
          <!--<xsl:call-template name="translateTelecomCode">
            <xsl:with-param name="code" select="$type"/>
          </xsl:call-template>-->
          <xsl:if test="@use">
            <xsl:text> (</xsl:text>
            <xsl:call-template name="translateTelecomCode">
              <xsl:with-param name="code" select="@use"/>
            </xsl:call-template>
            <xsl:text>)</xsl:text>
          </xsl:if>
          <xsl:text>: </xsl:text>
          <xsl:text> </xsl:text>
          <xsl:value-of select="$value"/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>Telecom information not available</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <br/>
  </xsl:template>
  <!-- show-recipientType -->
  <xsl:template name="show-recipientType">
    <xsl:param name="typeCode"/>
    <xsl:choose>
      <xsl:when test="$typeCode='PRCP'">Primary Recipient:</xsl:when>
      <xsl:when test="$typeCode='TRC'">Secondary Recipient:</xsl:when>
      <xsl:otherwise>Recipient:</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- Convert Telecom URL to display text -->
  <xsl:template name="translateTelecomCode">
    <xsl:param name="code"/>
    <!--xsl:value-of select="document('voc.xml')/systems/system[@root=$code/@codeSystem]/code[@value=$code/@code]/@displayName"/-->
    <!--xsl:value-of select="document('codes.xml')/*/code[@code=$code]/@display"/-->
    <xsl:choose>
      <!-- lookup table Telecom URI -->
      <xsl:when test="$code='tel'">
        <xsl:text>Tel</xsl:text>
      </xsl:when>
      <xsl:when test="$code='fax'">
        <xsl:text>Fax</xsl:text>
      </xsl:when>
      <xsl:when test="$code='http'">
        <xsl:text>Web</xsl:text>
      </xsl:when>
      <xsl:when test="$code='mailto'">
        <xsl:text>Mail</xsl:text>
      </xsl:when>
      <xsl:when test="$code='H'">
        <xsl:text>Home</xsl:text>
      </xsl:when>
      <xsl:when test="$code='HV'">
        <xsl:text>Vacation Home</xsl:text>
      </xsl:when>
      <xsl:when test="$code='HP'">
        <xsl:text>Primary Home</xsl:text>
      </xsl:when>
      <xsl:when test="$code='WP'">
        <xsl:text>Work Place</xsl:text>
      </xsl:when>
      <xsl:when test="$code='PUB'">
        <xsl:text>Pub</xsl:text>
      </xsl:when>
      <xsl:when test="$code='MC'">
        <xsl:text>Mobile</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>{$code='</xsl:text>
        <xsl:value-of select="$code"/>
        <xsl:text>'?}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="translateAddressCode">
    <xsl:param name="code"/>
    <!--xsl:value-of select="document('voc.xml')/systems/system[@root=$code/@codeSystem]/code[@value=$code/@code]/@displayName"/-->
    <!--xsl:value-of select="document('codes.xml')/*/code[@code=$code]/@display"/-->
    <xsl:choose>
      <!-- lookup table Telecom URI -->
      <xsl:when test="$code='tel'">
        <xsl:text>Tel</xsl:text>
      </xsl:when>
      <xsl:when test="$code='fax'">
        <xsl:text>Fax</xsl:text>
      </xsl:when>
      <xsl:when test="$code='http'">
        <xsl:text>Web</xsl:text>
      </xsl:when>
      <xsl:when test="$code='mailto'">
        <xsl:text>Mail</xsl:text>
      </xsl:when>
      <xsl:when test="$code='H'">
        <br/><xsl:text>Previous Address</xsl:text>
      </xsl:when>
      <xsl:when test="$code='HV'">
        <xsl:text>Vacation Home</xsl:text>
      </xsl:when>
      <xsl:when test="$code='HP'">
        <br/><xsl:text>Current Address</xsl:text>
      </xsl:when>
      <xsl:when test="$code='WP'">
        <xsl:text>Work Place</xsl:text>
      </xsl:when>
      <xsl:when test="$code='PUB'">
        <xsl:text>Pub</xsl:text>
      </xsl:when>
      <xsl:when test="$code='MC'">
        <xsl:text>Mobile</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>{$code='</xsl:text>
        <xsl:value-of select="$code"/>
        <xsl:text>'?}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- convert RoleClassAssociative code to display text -->
  <xsl:template name="translateRoleAssoCode">
    <xsl:param name="classCode"/>
    <xsl:param name="code"/>
    <xsl:choose>
      <xsl:when test="$classCode='AFFL'">
        <xsl:text>affiliate</xsl:text>
      </xsl:when>
      <xsl:when test="$classCode='AGNT'">
        <xsl:text>agent</xsl:text>
      </xsl:when>
      <xsl:when test="$classCode='ASSIGNED'">
        <xsl:text>assigned entity</xsl:text>
      </xsl:when>
      <xsl:when test="$classCode='COMPAR'">
        <xsl:text>commissioning party</xsl:text>
      </xsl:when>
      <xsl:when test="$classCode='CON'">
        <xsl:text>contact</xsl:text>
      </xsl:when>
      <xsl:when test="$classCode='ECON'">
        <xsl:text>emergency contact</xsl:text>
      </xsl:when>
      <xsl:when test="$classCode='NOK'">
        <xsl:text>next of kin</xsl:text>
      </xsl:when>
      <xsl:when test="$classCode='SGNOFF'">
        <xsl:text>signing authority</xsl:text>
      </xsl:when>
      <xsl:when test="$classCode='GUARD'">
        <xsl:text>guardian</xsl:text>
      </xsl:when>
      <xsl:when test="$classCode='GUAR'">
        <xsl:text>guardian</xsl:text>
      </xsl:when>
      <xsl:when test="$classCode='CIT'">
        <xsl:text>citizen</xsl:text>
      </xsl:when>
      <xsl:when test="$classCode='COVPTY'">
        <xsl:text>covered party</xsl:text>
      </xsl:when>
      <xsl:when test="$classCode='PRS'">
        <xsl:text>personal relationship</xsl:text>
      </xsl:when>
      <xsl:when test="$classCode='CAREGIVER'">
        <xsl:text>care giver</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>{$classCode='</xsl:text>
        <xsl:value-of select="$classCode"/>
        <xsl:text>'?}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="($code/@code) and ($code/@codeSystem='2.16.840.1.113883.5.111')">
      <xsl:text> </xsl:text>
      <xsl:choose>
        <xsl:when test="$code/@code='FTH'">
          <xsl:text>(Father)</xsl:text>
        </xsl:when>
        <xsl:when test="$code/@code='MTH'">
          <xsl:text>(Mother)</xsl:text>
        </xsl:when>
        <xsl:when test="$code/@code='NPRN'">
          <xsl:text>(Natural parent)</xsl:text>
        </xsl:when>
        <xsl:when test="$code/@code='STPPRN'">
          <xsl:text>(Step parent)</xsl:text>
        </xsl:when>
        <xsl:when test="$code/@code='SONC'">
          <xsl:text>(Son)</xsl:text>
        </xsl:when>
        <xsl:when test="$code/@code='DAUC'">
          <xsl:text>(Daughter)</xsl:text>
        </xsl:when>
        <xsl:when test="$code/@code='CHILD'">
          <xsl:text>(Child)</xsl:text>
        </xsl:when>
        <xsl:when test="$code/@code='EXT'">
          <xsl:text>(Extended family member)</xsl:text>
        </xsl:when>
        <xsl:when test="$code/@code='NBOR'">
          <xsl:text>(Neighbor)</xsl:text>
        </xsl:when>
        <xsl:when test="$code/@code='SIGOTHR'">
          <xsl:text>(Significant other)</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>{$code/@code='</xsl:text>
          <xsl:value-of select="$code/@code"/>
          <xsl:text>'?}</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  <!-- show time -->
  <xsl:template name="show-time">
    <xsl:param name="datetime"/>
    <xsl:choose>
      <xsl:when test="not($datetime)">
        <xsl:call-template name="formatDateTime">
          <xsl:with-param name="date" select="@value"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="formatDateTime">
          <xsl:with-param name="date" select="$datetime/@value"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- paticipant facility and date -->
  <xsl:template name="facilityAndDates">
    <table class="header_table">
      <tbody>
        <!-- facility id -->
        <tr>
          <td width="20%" bgcolor="#3399ff">
            <span class="td_label">
              <xsl:text>Facility ID</xsl:text>
            </span>
          </td>
          <td colspan="3">
            <xsl:choose>
              <xsl:when test="count(/n1:ClinicalDocument/n1:participant
                                      [@typeCode='LOC'][@contextControlCode='OP']
                                      /n1:associatedEntity[@classCode='SDLOC']/n1:id)&gt;0">
                <!-- change context node -->
                <xsl:for-each select="/n1:ClinicalDocument/n1:participant
                                      [@typeCode='LOC'][@contextControlCode='OP']
                                      /n1:associatedEntity[@classCode='SDLOC']/n1:id">
                  <xsl:call-template name="show-id"/>
                  <!-- change context node again, for the code -->
                  <xsl:for-each select="../n1:code">
                    <xsl:text> (</xsl:text>
                    <xsl:call-template name="show-code">
                      <xsl:with-param name="code" select="."/>
                    </xsl:call-template>
                    <xsl:text>)</xsl:text>
                  </xsl:for-each>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                Not available
              </xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
        <!-- Period reported -->
        <tr>
          <td width="20%" bgcolor="#3399ff">
            <span class="td_label">
              <xsl:text>First day of period reported</xsl:text>
            </span>
          </td>
          <td colspan="3">
            <xsl:call-template name="show-time">
              <xsl:with-param name="datetime" select="/n1:ClinicalDocument/n1:documentationOf
                                      /n1:serviceEvent/n1:effectiveTime/n1:low"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr>
          <td width="20%" bgcolor="#3399ff">
            <span class="td_label">
              <xsl:text>Last day of period reported</xsl:text>
            </span>
          </td>
          <td colspan="3">
            <xsl:call-template name="show-time">
              <xsl:with-param name="datetime" select="/n1:ClinicalDocument/n1:documentationOf
                                      /n1:serviceEvent/n1:effectiveTime/n1:high"/>
            </xsl:call-template>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>
  <!-- show assignedEntity -->
  <xsl:template name="show-assignedEntity">
    <xsl:param name="asgnEntity"/>
    <xsl:choose>
      <xsl:when test="$asgnEntity/n1:assignedPerson/n1:name">
        <xsl:call-template name="show-name">
          <xsl:with-param name="name" select="$asgnEntity/n1:assignedPerson/n1:name"/>
        </xsl:call-template>
        <xsl:if test="$asgnEntity/n1:representedOrganization/n1:name">
          <xsl:text> of </xsl:text>
          <xsl:value-of select="$asgnEntity/n1:representedOrganization/n1:name"/>
        </xsl:if>
      </xsl:when>
      <xsl:when test="$asgnEntity/n1:representedOrganization">
        <xsl:value-of select="$asgnEntity/n1:representedOrganization/n1:name"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="$asgnEntity/n1:id">
          <xsl:call-template name="show-id"/>
          <xsl:choose>
            <xsl:when test="position()!=last()">
              <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <br/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- show relatedEntity -->
  <xsl:template name="show-relatedEntity">
    <xsl:param name="relatedEntity"/>
    <xsl:choose>
      <xsl:when test="$relatedEntity/n1:relatedPerson/n1:name">
        <xsl:call-template name="show-name">
          <xsl:with-param name="name" select="$relatedEntity/n1:relatedPerson/n1:name"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- show associatedEntity -->
  <xsl:template name="show-associatedEntity">
    <xsl:param name="assoEntity"/>
    <xsl:choose>
      <xsl:when test="$assoEntity/n1:associatedPerson">
        <xsl:for-each select="$assoEntity/n1:associatedPerson/n1:name">
          <xsl:call-template name="show-name">
            <xsl:with-param name="name" select="."/>
          </xsl:call-template>
          <br/>
        </xsl:for-each>
      </xsl:when>
      <xsl:when test="$assoEntity/n1:scopingOrganization">
        <xsl:for-each select="$assoEntity/n1:scopingOrganization">
          <xsl:if test="n1:name">
            <xsl:call-template name="show-name">
              <xsl:with-param name="name" select="n1:name"/>
            </xsl:call-template>
            <br/>
          </xsl:if>
          <xsl:if test="n1:standardIndustryClassCode">
            <xsl:value-of select="n1:standardIndustryClassCode/@displayName"/>
            <xsl:text> code:</xsl:text>
            <xsl:value-of select="n1:standardIndustryClassCode/@code"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:when>
      <xsl:when test="$assoEntity/n1:code">
        <xsl:call-template name="show-code">
          <xsl:with-param name="code" select="$assoEntity/n1:code"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$assoEntity/n1:id">
        <xsl:value-of select="$assoEntity/n1:id/@extension"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$assoEntity/n1:id/@root"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- show code 
    if originalText present, return it, otherwise, check and return attribute: display name
    -->
  <xsl:template name="show-code">
    <xsl:param name="code"/>
    <xsl:variable name="this-codeSystem">
      <xsl:value-of select="$code/@codeSystem"/>
    </xsl:variable>
    <xsl:variable name="this-code">
      <xsl:value-of select="$code/@code"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$code/n1:originalText">
        <xsl:value-of select="$code/n1:originalText"/>
      </xsl:when>
      <xsl:when test="$code/@displayName">
        <xsl:value-of select="$code/@displayName"/>
      </xsl:when>
      <!--
      <xsl:when test="$the-valuesets/*/voc:system[@root=$this-codeSystem]/voc:code[@value=$this-code]/@displayName">
        <xsl:value-of select="$the-valuesets/*/voc:system[@root=$this-codeSystem]/voc:code[@value=$this-code]/@displayName"/>
      </xsl:when>
      -->
      <xsl:otherwise>
        <xsl:value-of select="$this-code"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- show classCode -->
  <xsl:template name="show-actClassCode">
    <xsl:param name="clsCode"/>
    <xsl:choose>
      <xsl:when test=" $clsCode = 'ACT' ">
        <xsl:text>healthcare service</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'ACCM' ">
        <xsl:text>accommodation</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'ACCT' ">
        <xsl:text>account</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'ACSN' ">
        <xsl:text>accession</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'ADJUD' ">
        <xsl:text>financial adjudication</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'CONS' ">
        <xsl:text>consent</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'CONTREG' ">
        <xsl:text>container registration</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'CTTEVENT' ">
        <xsl:text>clinical trial timepoint event</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'DISPACT' ">
        <xsl:text>disciplinary action</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'ENC' ">
        <xsl:text>encounter</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'INC' ">
        <xsl:text>incident</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'INFRM' ">
        <xsl:text>inform</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'INVE' ">
        <xsl:text>invoice element</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'LIST' ">
        <xsl:text>working list</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'MPROT' ">
        <xsl:text>monitoring program</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'PCPR' ">
        <xsl:text>care provision</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'PROC' ">
        <xsl:text>procedure</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'REG' ">
        <xsl:text>registration</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'REV' ">
        <xsl:text>review</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'SBADM' ">
        <xsl:text>substance administration</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'SPCTRT' ">
        <xsl:text>speciment treatment</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'SUBST' ">
        <xsl:text>substitution</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'TRNS' ">
        <xsl:text>transportation</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'VERIF' ">
        <xsl:text>verification</xsl:text>
      </xsl:when>
      <xsl:when test=" $clsCode = 'XACT' ">
        <xsl:text>financial transaction</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- relatedDocument -->
  <xsl:template match="n1:languageCommunication[n1:languageCode/@nullFlavor]">
    <div class="dataBlock language">
      <div class="value">Declined to Specify</div>
    </div>
  </xsl:template>
  <xsl:template match="n1:languageCommunication[not(n1:languageCode/@nullFlavor)]">
    <xsl:apply-templates select="n1:languageCode"/>
    <xsl:if test="n1:preferenceInd[@value='true']">
      <xsl:text> (preferred)</xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template match="n1:languageCode">
    <xsl:choose>
      <xsl:when test="@code='aa'">Afar</xsl:when>
      <xsl:when test="@code='ab'">Abkhazian</xsl:when>
      <xsl:when test="@code='ace'">Achinese</xsl:when>
      <xsl:when test="@code='ach'">Acoli</xsl:when>
      <xsl:when test="@code='ada'">Adangme</xsl:when>
      <xsl:when test="@code='ady'">Adyghe; Adygei</xsl:when>
      <xsl:when test="@code='afa'">Afro-Asiatic languages</xsl:when>
      <xsl:when test="@code='afh'">Afrihili</xsl:when>
      <xsl:when test="@code='af'">Afrikaans</xsl:when>
      <xsl:when test="@code='ain'">Ainu</xsl:when>
      <xsl:when test="@code='ak'">Akan</xsl:when>
      <xsl:when test="@code='akk'">Akkadian</xsl:when>
      <xsl:when test="@code='sq'">Albanian</xsl:when>
      <xsl:when test="@code='ale'">Aleut</xsl:when>
      <xsl:when test="@code='alg'">Algonquian languages</xsl:when>
      <xsl:when test="@code='alt'">Southern Altai</xsl:when>
      <xsl:when test="@code='am'">Amharic</xsl:when>
      <xsl:when test="@code='ang'">English, Old (ca.450-1100)</xsl:when>
      <xsl:when test="@code='anp'">Angika</xsl:when>
      <xsl:when test="@code='apa'">Apache languages</xsl:when>
      <xsl:when test="@code='ar'">Arabic</xsl:when>
      <xsl:when test="@code='arc'">Official Aramaic (700-300 BCE); Imperial Aramaic (700-300 BCE)</xsl:when>
      <xsl:when test="@code='an'">Aragonese</xsl:when>
      <xsl:when test="@code='hy'">Armenian</xsl:when>
      <xsl:when test="@code='arn'">Mapudungun; Mapuche</xsl:when>
      <xsl:when test="@code='arp'">Arapaho</xsl:when>
      <xsl:when test="@code='art'">Artificial languages</xsl:when>
      <xsl:when test="@code='arw'">Arawak</xsl:when>
      <xsl:when test="@code='as'">Assamese</xsl:when>
      <xsl:when test="@code='ast'">Asturian; Bable; Leonese; Asturleonese</xsl:when>
      <xsl:when test="@code='ath'">Athapascan languages</xsl:when>
      <xsl:when test="@code='aus'">Australian languages</xsl:when>
      <xsl:when test="@code='av'">Avaric</xsl:when>
      <xsl:when test="@code='ae'">Avestan</xsl:when>
      <xsl:when test="@code='awa'">Awadhi</xsl:when>
      <xsl:when test="@code='ay'">Aymara</xsl:when>
      <xsl:when test="@code='az'">Azerbaijani</xsl:when>
      <xsl:when test="@code='bad'">Banda languages</xsl:when>
      <xsl:when test="@code='bai'">Bamileke languages</xsl:when>
      <xsl:when test="@code='ba'">Bashkir</xsl:when>
      <xsl:when test="@code='bal'">Baluchi</xsl:when>
      <xsl:when test="@code='bm'">Bambara</xsl:when>
      <xsl:when test="@code='ban'">Balinese</xsl:when>
      <xsl:when test="@code='eu'">Basque</xsl:when>
      <xsl:when test="@code='bas'">Basa</xsl:when>
      <xsl:when test="@code='bat'">Baltic languages</xsl:when>
      <xsl:when test="@code='bej'">Beja; Bedawiyet</xsl:when>
      <xsl:when test="@code='be'">Belarusian</xsl:when>
      <xsl:when test="@code='bem'">Bemba</xsl:when>
      <xsl:when test="@code='bn'">Bengali</xsl:when>
      <xsl:when test="@code='ber'">Berber languages</xsl:when>
      <xsl:when test="@code='bho'">Bhojpuri</xsl:when>
      <xsl:when test="@code='bh'">Bihari languages</xsl:when>
      <xsl:when test="@code='bik'">Bikol</xsl:when>
      <xsl:when test="@code='bin'">Bini; Edo</xsl:when>
      <xsl:when test="@code='bi'">Bislama</xsl:when>
      <xsl:when test="@code='bla'">Siksika</xsl:when>
      <xsl:when test="@code='bnt'">Bantu languages</xsl:when>
      <xsl:when test="@code='bo'">Tibetan</xsl:when>
      <xsl:when test="@code='bs'">Bosnian</xsl:when>
      <xsl:when test="@code='bra'">Braj</xsl:when>
      <xsl:when test="@code='br'">Breton</xsl:when>
      <xsl:when test="@code='btk'">Batak languages</xsl:when>
      <xsl:when test="@code='bua'">Buriat</xsl:when>
      <xsl:when test="@code='bug'">Buginese</xsl:when>
      <xsl:when test="@code='bg'">Bulgarian</xsl:when>
      <xsl:when test="@code='my'">Burmese</xsl:when>
      <xsl:when test="@code='byn'">Blin; Bilin</xsl:when>
      <xsl:when test="@code='cad'">Caddo</xsl:when>
      <xsl:when test="@code='cai'">Central American Indian languages</xsl:when>
      <xsl:when test="@code='car'">Galibi Carib</xsl:when>
      <xsl:when test="@code='ca'">Catalan; Valencian</xsl:when>
      <xsl:when test="@code='cau'">Caucasian languages</xsl:when>
      <xsl:when test="@code='ceb'">Cebuano</xsl:when>
      <xsl:when test="@code='cel'">Celtic languages</xsl:when>
      <xsl:when test="@code='cs'">Czech</xsl:when>
      <xsl:when test="@code='ch'">Chamorro</xsl:when>
      <xsl:when test="@code='chb'">Chibcha</xsl:when>
      <xsl:when test="@code='ce'">Chechen</xsl:when>
      <xsl:when test="@code='chg'">Chagatai</xsl:when>
      <xsl:when test="@code='zh'">Chinese</xsl:when>
      <xsl:when test="@code='chk'">Chuukese</xsl:when>
      <xsl:when test="@code='chm'">Mari</xsl:when>
      <xsl:when test="@code='chn'">Chinook jargon</xsl:when>
      <xsl:when test="@code='cho'">Choctaw</xsl:when>
      <xsl:when test="@code='chp'">Chipewyan; Dene Suline</xsl:when>
      <xsl:when test="@code='chr'">Cherokee</xsl:when>
      <xsl:when test="@code='cu'">Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic</xsl:when>
      <xsl:when test="@code='cv'">Chuvash</xsl:when>
      <xsl:when test="@code='chy'">Cheyenne</xsl:when>
      <xsl:when test="@code='cmc'">Chamic languages</xsl:when>
      <xsl:when test="@code='cop'">Coptic</xsl:when>
      <xsl:when test="@code='kw'">Cornish</xsl:when>
      <xsl:when test="@code='co'">Corsican</xsl:when>
      <xsl:when test="@code='cpe'">Creoles and pidgins, English based</xsl:when>
      <xsl:when test="@code='cpf'">Creoles and pidgins, French-based</xsl:when>
      <xsl:when test="@code='cpp'">Creoles and pidgins, Portuguese-based</xsl:when>
      <xsl:when test="@code='cr'">Cree</xsl:when>
      <xsl:when test="@code='crh'">Crimean Tatar; Crimean Turkish</xsl:when>
      <xsl:when test="@code='crp'">Creoles and pidgins</xsl:when>
      <xsl:when test="@code='csb'">Kashubian</xsl:when>
      <xsl:when test="@code='cus'">Cushitic languages</xsl:when>
      <xsl:when test="@code='cy'">Welsh</xsl:when>
      <xsl:when test="@code='dak'">Dakota</xsl:when>
      <xsl:when test="@code='da'">Danish</xsl:when>
      <xsl:when test="@code='dar'">Dargwa</xsl:when>
      <xsl:when test="@code='day'">Land Dayak languages</xsl:when>
      <xsl:when test="@code='del'">Delaware</xsl:when>
      <xsl:when test="@code='den'">Slave (Athapascan)</xsl:when>
      <xsl:when test="@code='de'">German</xsl:when>
      <xsl:when test="@code='dgr'">Dogrib</xsl:when>
      <xsl:when test="@code='din'">Dinka</xsl:when>
      <xsl:when test="@code='dv'">Divehi; Dhivehi; Maldivian</xsl:when>
      <xsl:when test="@code='doi'">Dogri</xsl:when>
      <xsl:when test="@code='dra'">Dravidian languages</xsl:when>
      <xsl:when test="@code='dsb'">Lower Sorbian</xsl:when>
      <xsl:when test="@code='dua'">Duala</xsl:when>
      <xsl:when test="@code='dum'">Dutch, Middle (ca.1050-1350)</xsl:when>
      <xsl:when test="@code='nl'">Dutch; Flemish</xsl:when>
      <xsl:when test="@code='dyu'">Dyula</xsl:when>
      <xsl:when test="@code='dz'">Dzongkha</xsl:when>
      <xsl:when test="@code='efi'">Efik</xsl:when>
      <xsl:when test="@code='egy'">Egyptian (Ancient)</xsl:when>
      <xsl:when test="@code='eka'">Ekajuk</xsl:when>
      <xsl:when test="@code='el'">Greek, Modern (1453-)</xsl:when>
      <xsl:when test="@code='elx'">Elamite</xsl:when>
      <xsl:when test="@code='en'">English</xsl:when>
      <xsl:when test="@code='eng'">English</xsl:when>
      <xsl:when test="@code='en-US'">English</xsl:when>
      <xsl:when test="@code='enm'">English, Middle (1100-1500)</xsl:when>
      <xsl:when test="@code='eo'">Esperanto</xsl:when>
      <xsl:when test="@code='et'">Estonian</xsl:when>
      <xsl:when test="@code='ee'">Ewe</xsl:when>
      <xsl:when test="@code='ewo'">Ewondo</xsl:when>
      <xsl:when test="@code='fan'">Fang</xsl:when>
      <xsl:when test="@code='fo'">Faroese</xsl:when>
      <xsl:when test="@code='fa'">Persian</xsl:when>
      <xsl:when test="@code='fat'">Fanti</xsl:when>
      <xsl:when test="@code='fj'">Fijian</xsl:when>
      <xsl:when test="@code='fil'">Filipino; Pilipino</xsl:when>
      <xsl:when test="@code='fi'">Finnish</xsl:when>
      <xsl:when test="@code='fiu'">Finno-Ugrian languages</xsl:when>
      <xsl:when test="@code='fon'">Fon</xsl:when>
      <xsl:when test="@code='fr'">French</xsl:when>
      <xsl:when test="@code='frm'">French, Middle (ca.1400-1600)</xsl:when>
      <xsl:when test="@code='fro'">French, Old (842-ca.1400)</xsl:when>
      <xsl:when test="@code='frr'">Northern Frisian</xsl:when>
      <xsl:when test="@code='frs'">Eastern Frisian</xsl:when>
      <xsl:when test="@code='fy'">Western Frisian</xsl:when>
      <xsl:when test="@code='ff'">Fulah</xsl:when>
      <xsl:when test="@code='fur'">Friulian</xsl:when>
      <xsl:when test="@code='gaa'">Ga</xsl:when>
      <xsl:when test="@code='gay'">Gayo</xsl:when>
      <xsl:when test="@code='gba'">Gbaya</xsl:when>
      <xsl:when test="@code='gem'">Germanic languages</xsl:when>
      <xsl:when test="@code='ka'">Georgian</xsl:when>
      <xsl:when test="@code='gez'">Geez</xsl:when>
      <xsl:when test="@code='gil'">Gilbertese</xsl:when>
      <xsl:when test="@code='gd'">Gaelic; Scottish Gaelic</xsl:when>
      <xsl:when test="@code='ga'">Irish</xsl:when>
      <xsl:when test="@code='gl'">Galician</xsl:when>
      <xsl:when test="@code='gv'">Manx</xsl:when>
      <xsl:when test="@code='gmh'">German, Middle High (ca.1050-1500)</xsl:when>
      <xsl:when test="@code='goh'">German, Old High (ca.750-1050)</xsl:when>
      <xsl:when test="@code='gon'">Gondi</xsl:when>
      <xsl:when test="@code='gor'">Gorontalo</xsl:when>
      <xsl:when test="@code='got'">Gothic</xsl:when>
      <xsl:when test="@code='grb'">Grebo</xsl:when>
      <xsl:when test="@code='grc'">Greek, Ancient (to 1453)</xsl:when>
      <xsl:when test="@code='gn'">Guarani</xsl:when>
      <xsl:when test="@code='gsw'">Swiss German; Alemannic; Alsatian</xsl:when>
      <xsl:when test="@code='gu'">Gujarati</xsl:when>
      <xsl:when test="@code='gwi'">Gwich'in</xsl:when>
      <xsl:when test="@code='hai'">Haida</xsl:when>
      <xsl:when test="@code='ht'">Haitian; Haitian Creole</xsl:when>
      <xsl:when test="@code='ha'">Hausa</xsl:when>
      <xsl:when test="@code='haw'">Hawaiian</xsl:when>
      <xsl:when test="@code='he'">Hebrew</xsl:when>
      <xsl:when test="@code='hz'">Herero</xsl:when>
      <xsl:when test="@code='hil'">Hiligaynon</xsl:when>
      <xsl:when test="@code='him'">Himachali languages; Western Pahari languages</xsl:when>
      <xsl:when test="@code='hi'">Hindi</xsl:when>
      <xsl:when test="@code='hit'">Hittite</xsl:when>
      <xsl:when test="@code='hmn'">Hmong; Mong</xsl:when>
      <xsl:when test="@code='ho'">Hiri Motu</xsl:when>
      <xsl:when test="@code='hr'">Croatian</xsl:when>
      <xsl:when test="@code='hsb'">Upper Sorbian</xsl:when>
      <xsl:when test="@code='hu'">Hungarian</xsl:when>
      <xsl:when test="@code='hup'">Hupa</xsl:when>
      <xsl:when test="@code='iba'">Iban</xsl:when>
      <xsl:when test="@code='ig'">Igbo</xsl:when>
      <xsl:when test="@code='is'">Icelandic</xsl:when>
      <xsl:when test="@code='io'">Ido</xsl:when>
      <xsl:when test="@code='ii'">Sichuan Yi; Nuosu</xsl:when>
      <xsl:when test="@code='ijo'">Ijo languages</xsl:when>
      <xsl:when test="@code='iu'">Inuktitut</xsl:when>
      <xsl:when test="@code='ie'">Interlingue; Occidental</xsl:when>
      <xsl:when test="@code='ilo'">Iloko</xsl:when>
      <xsl:when test="@code='ia'">Interlingua (International Auxiliary Language Association)</xsl:when>
      <xsl:when test="@code='inc'">Indic languages</xsl:when>
      <xsl:when test="@code='id'">Indonesian</xsl:when>
      <xsl:when test="@code='ine'">Indo-European languages</xsl:when>
      <xsl:when test="@code='inh'">Ingush</xsl:when>
      <xsl:when test="@code='ik'">Inupiaq</xsl:when>
      <xsl:when test="@code='ira'">Iranian languages</xsl:when>
      <xsl:when test="@code='iro'">Iroquoian languages</xsl:when>
      <xsl:when test="@code='it'">Italian</xsl:when>
      <xsl:when test="@code='jv'">Javanese</xsl:when>
      <xsl:when test="@code='jbo'">Lojban</xsl:when>
      <xsl:when test="@code='ja'">Japanese</xsl:when>
      <xsl:when test="@code='jpr'">Judeo-Persian</xsl:when>
      <xsl:when test="@code='jrb'">Judeo-Arabic</xsl:when>
      <xsl:when test="@code='kaa'">Kara-Kalpak</xsl:when>
      <xsl:when test="@code='kab'">Kabyle</xsl:when>
      <xsl:when test="@code='kac'">Kachin; Jingpho</xsl:when>
      <xsl:when test="@code='kl'">Kalaallisut; Greenlandic</xsl:when>
      <xsl:when test="@code='kam'">Kamba</xsl:when>
      <xsl:when test="@code='kn'">Kannada</xsl:when>
      <xsl:when test="@code='kar'">Karen languages</xsl:when>
      <xsl:when test="@code='ks'">Kashmiri</xsl:when>
      <xsl:when test="@code='kr'">Kanuri</xsl:when>
      <xsl:when test="@code='kaw'">Kawi</xsl:when>
      <xsl:when test="@code='kk'">Kazakh</xsl:when>
      <xsl:when test="@code='kbd'">Kabardian</xsl:when>
      <xsl:when test="@code='kha'">Khasi</xsl:when>
      <xsl:when test="@code='khi'">Khoisan languages</xsl:when>
      <xsl:when test="@code='km'">Central Khmer</xsl:when>
      <xsl:when test="@code='kho'">Khotanese; Sakan</xsl:when>
      <xsl:when test="@code='ki'">Kikuyu; Gikuyu</xsl:when>
      <xsl:when test="@code='rw'">Kinyarwanda</xsl:when>
      <xsl:when test="@code='ky'">Kirghiz; Kyrgyz</xsl:when>
      <xsl:when test="@code='kmb'">Kimbundu</xsl:when>
      <xsl:when test="@code='kok'">Konkani</xsl:when>
      <xsl:when test="@code='kv'">Komi</xsl:when>
      <xsl:when test="@code='kg'">Kongo</xsl:when>
      <xsl:when test="@code='ko'">Korean</xsl:when>
      <xsl:when test="@code='kos'">Kosraean</xsl:when>
      <xsl:when test="@code='kpe'">Kpelle</xsl:when>
      <xsl:when test="@code='krc'">Karachay-Balkar</xsl:when>
      <xsl:when test="@code='krl'">Karelian</xsl:when>
      <xsl:when test="@code='kro'">Kru languages</xsl:when>
      <xsl:when test="@code='kru'">Kurukh</xsl:when>
      <xsl:when test="@code='kj'">Kuanyama; Kwanyama</xsl:when>
      <xsl:when test="@code='kum'">Kumyk</xsl:when>
      <xsl:when test="@code='ku'">Kurdish</xsl:when>
      <xsl:when test="@code='kut'">Kutenai</xsl:when>
      <xsl:when test="@code='lad'">Ladino</xsl:when>
      <xsl:when test="@code='lah'">Lahnda</xsl:when>
      <xsl:when test="@code='lam'">Lamba</xsl:when>
      <xsl:when test="@code='lo'">Lao</xsl:when>
      <xsl:when test="@code='la'">Latin</xsl:when>
      <xsl:when test="@code='lv'">Latvian</xsl:when>
      <xsl:when test="@code='lez'">Lezghian</xsl:when>
      <xsl:when test="@code='li'">Limburgan; Limburger; Limburgish</xsl:when>
      <xsl:when test="@code='ln'">Lingala</xsl:when>
      <xsl:when test="@code='lt'">Lithuanian</xsl:when>
      <xsl:when test="@code='lol'">Mongo</xsl:when>
      <xsl:when test="@code='loz'">Lozi</xsl:when>
      <xsl:when test="@code='lb'">Luxembourgish; Letzeburgesch</xsl:when>
      <xsl:when test="@code='lua'">Luba-Lulua</xsl:when>
      <xsl:when test="@code='lu'">Luba-Katanga</xsl:when>
      <xsl:when test="@code='lg'">Ganda</xsl:when>
      <xsl:when test="@code='lui'">Luiseno</xsl:when>
      <xsl:when test="@code='lun'">Lunda</xsl:when>
      <xsl:when test="@code='luo'">Luo (Kenya and Tanzania)</xsl:when>
      <xsl:when test="@code='lus'">Lushai</xsl:when>
      <xsl:when test="@code='mk'">Macedonian</xsl:when>
      <xsl:when test="@code='mad'">Madurese</xsl:when>
      <xsl:when test="@code='mag'">Magahi</xsl:when>
      <xsl:when test="@code='mh'">Marshallese</xsl:when>
      <xsl:when test="@code='mai'">Maithili</xsl:when>
      <xsl:when test="@code='mak'">Makasar</xsl:when>
      <xsl:when test="@code='ml'">Malayalam</xsl:when>
      <xsl:when test="@code='man'">Mandingo</xsl:when>
      <xsl:when test="@code='mi'">Maori</xsl:when>
      <xsl:when test="@code='map'">Austronesian languages</xsl:when>
      <xsl:when test="@code='mr'">Marathi</xsl:when>
      <xsl:when test="@code='mas'">Masai</xsl:when>
      <xsl:when test="@code='ms'">Malay</xsl:when>
      <xsl:when test="@code='mdf'">Moksha</xsl:when>
      <xsl:when test="@code='mdr'">Mandar</xsl:when>
      <xsl:when test="@code='men'">Mende</xsl:when>
      <xsl:when test="@code='mga'">Irish, Middle (900-1200)</xsl:when>
      <xsl:when test="@code='mic'">Mi'kmaq; Micmac</xsl:when>
      <xsl:when test="@code='min'">Minangkabau</xsl:when>
      <xsl:when test="@code='mis'">Uncoded languages</xsl:when>
      <xsl:when test="@code='mkh'">Mon-Khmer languages</xsl:when>
      <xsl:when test="@code='mg'">Malagasy</xsl:when>
      <xsl:when test="@code='mt'">Maltese</xsl:when>
      <xsl:when test="@code='mnc'">Manchu</xsl:when>
      <xsl:when test="@code='mni'">Manipuri</xsl:when>
      <xsl:when test="@code='mno'">Manobo languages</xsl:when>
      <xsl:when test="@code='moh'">Mohawk</xsl:when>
      <xsl:when test="@code='mn'">Mongolian</xsl:when>
      <xsl:when test="@code='mos'">Mossi</xsl:when>
      <xsl:when test="@code='mul'">Multiple languages</xsl:when>
      <xsl:when test="@code='mun'">Munda languages</xsl:when>
      <xsl:when test="@code='mus'">Creek</xsl:when>
      <xsl:when test="@code='mwl'">Mirandese</xsl:when>
      <xsl:when test="@code='mwr'">Marwari</xsl:when>
      <xsl:when test="@code='myn'">Mayan languages</xsl:when>
      <xsl:when test="@code='myv'">Erzya</xsl:when>
      <xsl:when test="@code='nah'">Nahuatl languages</xsl:when>
      <xsl:when test="@code='nai'">North American Indian languages</xsl:when>
      <xsl:when test="@code='nap'">Neapolitan</xsl:when>
      <xsl:when test="@code='na'">Nauru</xsl:when>
      <xsl:when test="@code='nv'">Navajo; Navaho</xsl:when>
      <xsl:when test="@code='nr'">Ndebele, South; South Ndebele</xsl:when>
      <xsl:when test="@code='nd'">Ndebele, North; North Ndebele</xsl:when>
      <xsl:when test="@code='ng'">Ndonga</xsl:when>
      <xsl:when test="@code='nds'">Low German; Low Saxon; German, Low; Saxon, Low</xsl:when>
      <xsl:when test="@code='ne'">Nepali</xsl:when>
      <xsl:when test="@code='new'">Nepal Bhasa; Newari</xsl:when>
      <xsl:when test="@code='nia'">Nias</xsl:when>
      <xsl:when test="@code='nic'">Niger-Kordofanian languages</xsl:when>
      <xsl:when test="@code='niu'">Niuean</xsl:when>
      <xsl:when test="@code='nn'">Norwegian Nynorsk; Nynorsk, Norwegian</xsl:when>
      <xsl:when test="@code='nb'">Bokmål, Norwegian; Norwegian Bokmål</xsl:when>
      <xsl:when test="@code='nog'">Nogai</xsl:when>
      <xsl:when test="@code='non'">Norse, Old</xsl:when>
      <xsl:when test="@code='no'">Norwegian</xsl:when>
      <xsl:when test="@code='nqo'">N'Ko</xsl:when>
      <xsl:when test="@code='nso'">Pedi; Sepedi; Northern Sotho</xsl:when>
      <xsl:when test="@code='nub'">Nubian languages</xsl:when>
      <xsl:when test="@code='nwc'">Classical Newari; Old Newari; Classical Nepal Bhasa</xsl:when>
      <xsl:when test="@code='ny'">Chichewa; Chewa; Nyanja</xsl:when>
      <xsl:when test="@code='nym'">Nyamwezi</xsl:when>
      <xsl:when test="@code='nyn'">Nyankole</xsl:when>
      <xsl:when test="@code='nyo'">Nyoro</xsl:when>
      <xsl:when test="@code='nzi'">Nzima</xsl:when>
      <xsl:when test="@code='oc'">Occitan (post 1500)</xsl:when>
      <xsl:when test="@code='oj'">Ojibwa</xsl:when>
      <xsl:when test="@code='or'">Oriya</xsl:when>
      <xsl:when test="@code='om'">Oromo</xsl:when>
      <xsl:when test="@code='osa'">Osage</xsl:when>
      <xsl:when test="@code='os'">Ossetian; Ossetic</xsl:when>
      <xsl:when test="@code='ota'">Turkish, Ottoman (1500-1928)</xsl:when>
      <xsl:when test="@code='oto'">Otomian languages</xsl:when>
      <xsl:when test="@code='paa'">Papuan languages</xsl:when>
      <xsl:when test="@code='pag'">Pangasinan</xsl:when>
      <xsl:when test="@code='pal'">Pahlavi</xsl:when>
      <xsl:when test="@code='pam'">Pampanga; Kapampangan</xsl:when>
      <xsl:when test="@code='pa'">Panjabi; Punjabi</xsl:when>
      <xsl:when test="@code='pap'">Papiamento</xsl:when>
      <xsl:when test="@code='pau'">Palauan</xsl:when>
      <xsl:when test="@code='peo'">Persian, Old (ca.600-400 B.C.)</xsl:when>
      <xsl:when test="@code='phi'">Philippine languages</xsl:when>
      <xsl:when test="@code='phn'">Phoenician</xsl:when>
      <xsl:when test="@code='pi'">Pali</xsl:when>
      <xsl:when test="@code='pl'">Polish</xsl:when>
      <xsl:when test="@code='pon'">Pohnpeian</xsl:when>
      <xsl:when test="@code='pt'">Portuguese</xsl:when>
      <xsl:when test="@code='pra'">Prakrit languages</xsl:when>
      <xsl:when test="@code='pro'">Provençal, Old (to 1500);Occitan, Old (to 1500)</xsl:when>
      <xsl:when test="@code='ps'">Pushto; Pashto</xsl:when>
      <xsl:when test="@code='qaa-qtz'">Reserved for local use</xsl:when>
      <xsl:when test="@code='qu'">Quechua</xsl:when>
      <xsl:when test="@code='raj'">Rajasthani</xsl:when>
      <xsl:when test="@code='rap'">Rapanui</xsl:when>
      <xsl:when test="@code='rar'">Rarotongan; Cook Islands Maori</xsl:when>
      <xsl:when test="@code='roa'">Romance languages</xsl:when>
      <xsl:when test="@code='rm'">Romansh</xsl:when>
      <xsl:when test="@code='rom'">Romany</xsl:when>
      <xsl:when test="@code='ro'">Romanian; Moldavian; Moldovan</xsl:when>
      <xsl:when test="@code='rn'">Rundi</xsl:when>
      <xsl:when test="@code='rup'">Aromanian; Arumanian; Macedo-Romanian</xsl:when>
      <xsl:when test="@code='ru'">Russian</xsl:when>
      <xsl:when test="@code='sad'">Sandawe</xsl:when>
      <xsl:when test="@code='sg'">Sango</xsl:when>
      <xsl:when test="@code='sah'">Yakut</xsl:when>
      <xsl:when test="@code='sai'">South American Indian languages</xsl:when>
      <xsl:when test="@code='sal'">Salishan languages</xsl:when>
      <xsl:when test="@code='sam'">Samaritan Aramaic</xsl:when>
      <xsl:when test="@code='sa'">Sanskrit</xsl:when>
      <xsl:when test="@code='sas'">Sasak</xsl:when>
      <xsl:when test="@code='sat'">Santali</xsl:when>
      <xsl:when test="@code='scn'">Sicilian</xsl:when>
      <xsl:when test="@code='sco'">Scots</xsl:when>
      <xsl:when test="@code='sel'">Selkup</xsl:when>
      <xsl:when test="@code='sem'">Semitic languages</xsl:when>
      <xsl:when test="@code='sga'">Irish, Old (to 900)</xsl:when>
      <xsl:when test="@code='sgn'">Sign Languages</xsl:when>
      <xsl:when test="@code='shn'">Shan</xsl:when>
      <xsl:when test="@code='sid'">Sidamo</xsl:when>
      <xsl:when test="@code='si'">Sinhala; Sinhalese</xsl:when>
      <xsl:when test="@code='sio'">Siouan languages</xsl:when>
      <xsl:when test="@code='sit'">Sino-Tibetan languages</xsl:when>
      <xsl:when test="@code='sla'">Slavic languages</xsl:when>
      <xsl:when test="@code='sk'">Slovak</xsl:when>
      <xsl:when test="@code='sl'">Slovenian</xsl:when>
      <xsl:when test="@code='sma'">Southern Sami</xsl:when>
      <xsl:when test="@code='se'">Northern Sami</xsl:when>
      <xsl:when test="@code='smi'">Sami languages</xsl:when>
      <xsl:when test="@code='smj'">Lule Sami</xsl:when>
      <xsl:when test="@code='smn'">Inari Sami</xsl:when>
      <xsl:when test="@code='sm'">Samoan</xsl:when>
      <xsl:when test="@code='sms'">Skolt Sami</xsl:when>
      <xsl:when test="@code='sn'">Shona</xsl:when>
      <xsl:when test="@code='sd'">Sindhi</xsl:when>
      <xsl:when test="@code='snk'">Soninke</xsl:when>
      <xsl:when test="@code='sog'">Sogdian</xsl:when>
      <xsl:when test="@code='so'">Somali</xsl:when>
      <xsl:when test="@code='son'">Songhai languages</xsl:when>
      <xsl:when test="@code='st'">Sotho, Southern</xsl:when>
      <xsl:when test="@code='es'">Spanish; Castilian</xsl:when>
      <xsl:when test="@code='sc'">Sardinian</xsl:when>
      <xsl:when test="@code='srn'">Sranan Tongo</xsl:when>
      <xsl:when test="@code='sr'">Serbian</xsl:when>
      <xsl:when test="@code='srr'">Serer</xsl:when>
      <xsl:when test="@code='ssa'">Nilo-Saharan languages</xsl:when>
      <xsl:when test="@code='ss'">Swati</xsl:when>
      <xsl:when test="@code='suk'">Sukuma</xsl:when>
      <xsl:when test="@code='su'">Sundanese</xsl:when>
      <xsl:when test="@code='sus'">Susu</xsl:when>
      <xsl:when test="@code='sux'">Sumerian</xsl:when>
      <xsl:when test="@code='sw'">Swahili</xsl:when>
      <xsl:when test="@code='sv'">Swedish</xsl:when>
      <xsl:when test="@code='syc'">Classical Syriac</xsl:when>
      <xsl:when test="@code='syr'">Syriac</xsl:when>
      <xsl:when test="@code='ty'">Tahitian</xsl:when>
      <xsl:when test="@code='tai'">Tai languages</xsl:when>
      <xsl:when test="@code='ta'">Tamil</xsl:when>
      <xsl:when test="@code='tt'">Tatar</xsl:when>
      <xsl:when test="@code='te'">Telugu</xsl:when>
      <xsl:when test="@code='tem'">Timne</xsl:when>
      <xsl:when test="@code='ter'">Tereno</xsl:when>
      <xsl:when test="@code='tet'">Tetum</xsl:when>
      <xsl:when test="@code='tg'">Tajik</xsl:when>
      <xsl:when test="@code='tl'">Tagalog</xsl:when>
      <xsl:when test="@code='th'">Thai</xsl:when>
      <xsl:when test="@code='tig'">Tigre</xsl:when>
      <xsl:when test="@code='ti'">Tigrinya</xsl:when>
      <xsl:when test="@code='tiv'">Tiv</xsl:when>
      <xsl:when test="@code='tkl'">Tokelau</xsl:when>
      <xsl:when test="@code='tlh'">Klingon; tlhIngan-Hol</xsl:when>
      <xsl:when test="@code='tli'">Tlingit</xsl:when>
      <xsl:when test="@code='tmh'">Tamashek</xsl:when>
      <xsl:when test="@code='tog'">Tonga (Nyasa)</xsl:when>
      <xsl:when test="@code='to'">Tonga (Tonga Islands)</xsl:when>
      <xsl:when test="@code='tpi'">Tok Pisin</xsl:when>
      <xsl:when test="@code='tsi'">Tsimshian</xsl:when>
      <xsl:when test="@code='tn'">Tswana</xsl:when>
      <xsl:when test="@code='ts'">Tsonga</xsl:when>
      <xsl:when test="@code='tk'">Turkmen</xsl:when>
      <xsl:when test="@code='tum'">Tumbuka</xsl:when>
      <xsl:when test="@code='tup'">Tupi languages</xsl:when>
      <xsl:when test="@code='tr'">Turkish</xsl:when>
      <xsl:when test="@code='tut'">Altaic languages</xsl:when>
      <xsl:when test="@code='tvl'">Tuvalu</xsl:when>
      <xsl:when test="@code='tw'">Twi</xsl:when>
      <xsl:when test="@code='tyv'">Tuvinian</xsl:when>
      <xsl:when test="@code='udm'">Udmurt</xsl:when>
      <xsl:when test="@code='uga'">Ugaritic</xsl:when>
      <xsl:when test="@code='ug'">Uighur; Uyghur</xsl:when>
      <xsl:when test="@code='uk'">Ukrainian</xsl:when>
      <xsl:when test="@code='umb'">Umbundu</xsl:when>
      <xsl:when test="@code='und'">Undetermined</xsl:when>
      <xsl:when test="@code='ur'">Urdu</xsl:when>
      <xsl:when test="@code='uz'">Uzbek</xsl:when>
      <xsl:when test="@code='vai'">Vai</xsl:when>
      <xsl:when test="@code='ve'">Venda</xsl:when>
      <xsl:when test="@code='vi'">Vietnamese</xsl:when>
      <xsl:when test="@code='vo'">Volapük</xsl:when>
      <xsl:when test="@code='vot'">Votic</xsl:when>
      <xsl:when test="@code='wak'">Wakashan languages</xsl:when>
      <xsl:when test="@code='wal'">Wolaitta; Wolaytta</xsl:when>
      <xsl:when test="@code='war'">Waray</xsl:when>
      <xsl:when test="@code='was'">Washo</xsl:when>
      <xsl:when test="@code='wen'">Sorbian languages</xsl:when>
      <xsl:when test="@code='wa'">Walloon</xsl:when>
      <xsl:when test="@code='wo'">Wolof</xsl:when>
      <xsl:when test="@code='xal'">Kalmyk; Oirat</xsl:when>
      <xsl:when test="@code='xh'">Xhosa</xsl:when>
      <xsl:when test="@code='yao'">Yao</xsl:when>
      <xsl:when test="@code='yap'">Yapese</xsl:when>
      <xsl:when test="@code='yi'">Yiddish</xsl:when>
      <xsl:when test="@code='yo'">Yoruba</xsl:when>
      <xsl:when test="@code='ypk'">Yupik languages</xsl:when>
      <xsl:when test="@code='zap'">Zapotec</xsl:when>
      <xsl:when test="@code='zbl'">Blissymbols; Blissymbolics; Bliss</xsl:when>
      <xsl:when test="@code='zen'">Zenaga</xsl:when>
      <xsl:when test="@code='zgh'">Standard Moroccan Tamazight</xsl:when>
      <xsl:when test="@code='za'">Zhuang; Chuang</xsl:when>
      <xsl:when test="@code='znd'">Zande languages</xsl:when>
      <xsl:when test="@code='zu'">Zulu</xsl:when>
      <xsl:when test="@code='zun'">Zuni</xsl:when>
      <xsl:when test="@code='zxx'">No linguistic content; Not applicable</xsl:when>
      <xsl:when test="@code='zza'">Zaza; Dimili; Dimli; Kirdki; Kirmanjki; Zazaki</xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@code"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- show participationType -->
  <xsl:template name="show-participationType">
    <xsl:param name="ptype"/>
    <xsl:choose>
      <xsl:when test=" $ptype='PPRF' ">
        <xsl:text>primary performer</xsl:text>
      </xsl:when>
      <xsl:when test=" $ptype='PRF' ">
        <xsl:text>performer</xsl:text>
      </xsl:when>
      <xsl:when test=" $ptype='VRF' ">
        <xsl:text>verifier</xsl:text>
      </xsl:when>
      <xsl:when test=" $ptype='SPRF' ">
        <xsl:text>secondary performer</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- show participationFunction -->
  <xsl:template name="show-participationFunction">
    <xsl:param name="pFunction"/>
    <xsl:choose>
      <!-- From the HL7 v3 ParticipationFunction code system -->
      <xsl:when test=" $pFunction = 'ADMPHYS' ">
        <xsl:text>(admitting physician)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'ANEST' ">
        <xsl:text>(anesthesist)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'ANRS' ">
        <xsl:text>(anesthesia nurse)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'ATTPHYS' ">
        <xsl:text>(attending physician)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'DISPHYS' ">
        <xsl:text>(discharging physician)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'FASST' ">
        <xsl:text>(first assistant surgeon)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'MDWF' ">
        <xsl:text>(midwife)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'NASST' ">
        <xsl:text>(nurse assistant)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'PCP' ">
        <xsl:text>(primary care physician)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'PRISURG' ">
        <xsl:text>(primary surgeon)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'RNDPHYS' ">
        <xsl:text>(rounding physician)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'SASST' ">
        <xsl:text>(second assistant surgeon)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'SNRS' ">
        <xsl:text>(scrub nurse)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'TASST' ">
        <xsl:text>(third assistant)</xsl:text>
      </xsl:when>
      <!-- From the HL7 v2 Provider Role code system (2.16.840.1.113883.12.443) which is used by HITSP -->
      <xsl:when test=" $pFunction = 'CP' ">
        <xsl:text>(consulting provider)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'PP' ">
        <xsl:text>(primary care provider)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'RP' ">
        <xsl:text>(referring provider)</xsl:text>
      </xsl:when>
      <xsl:when test=" $pFunction = 'MP' ">
        <xsl:text>(medical home provider)</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="formatDateTime">
    <xsl:param name="date"/>
    <!-- month -->
    <xsl:variable name="month" select="substring ($date, 5, 2)"/>
    <xsl:choose>
      <xsl:when test="$month='01'">
        <xsl:text>January </xsl:text>
      </xsl:when>
      <xsl:when test="$month='02'">
        <xsl:text>February </xsl:text>
      </xsl:when>
      <xsl:when test="$month='03'">
        <xsl:text>March </xsl:text>
      </xsl:when>
      <xsl:when test="$month='04'">
        <xsl:text>April </xsl:text>
      </xsl:when>
      <xsl:when test="$month='05'">
        <xsl:text>May </xsl:text>
      </xsl:when>
      <xsl:when test="$month='06'">
        <xsl:text>June </xsl:text>
      </xsl:when>
      <xsl:when test="$month='07'">
        <xsl:text>July </xsl:text>
      </xsl:when>
      <xsl:when test="$month='08'">
        <xsl:text>August </xsl:text>
      </xsl:when>
      <xsl:when test="$month='09'">
        <xsl:text>September </xsl:text>
      </xsl:when>
      <xsl:when test="$month='10'">
        <xsl:text>October </xsl:text>
      </xsl:when>
      <xsl:when test="$month='11'">
        <xsl:text>November </xsl:text>
      </xsl:when>
      <xsl:when test="$month='12'">
        <xsl:text>December </xsl:text>
      </xsl:when>
    </xsl:choose>
    <!-- day -->
    <xsl:choose>
      <xsl:when test='substring ($date, 7, 1)="0"'>
        <xsl:value-of select="substring ($date, 8, 1)"/>
        <xsl:text>, </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring ($date, 7, 2)"/>
        <xsl:text>, </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <!-- year -->
    <xsl:value-of select="substring ($date, 1, 4)"/>
    <!-- time and US timezone -->
    <xsl:if test="string-length($date) > 8">
      <xsl:text>, </xsl:text>
      <!-- time -->
      <xsl:variable name="time">
        <xsl:value-of select="substring($date,9,6)"/>
      </xsl:variable>
      <xsl:variable name="hh">
        <xsl:value-of select="substring($time,1,2)"/>
      </xsl:variable>
      <xsl:variable name="mm">
        <xsl:value-of select="substring($time,3,2)"/>
      </xsl:variable>
      <xsl:variable name="ss">
        <xsl:value-of select="substring($time,5,2)"/>
      </xsl:variable>
      <xsl:if test="string-length($hh)&gt;1">
        <xsl:value-of select="$hh"/>
        <xsl:if test="string-length($mm)&gt;1 and not(contains($mm,'-')) and not (contains($mm,'+'))">
          <xsl:text>:</xsl:text>
          <xsl:value-of select="$mm"/>
          <xsl:if test="string-length($ss)&gt;1 and not(contains($ss,'-')) and not (contains($ss,'+'))">
            <xsl:text>:</xsl:text>
            <xsl:value-of select="$ss"/>
          </xsl:if>
        </xsl:if>
      </xsl:if>
      <!-- time zone -->
      <xsl:variable name="tzon">
        <xsl:choose>
          <xsl:when test="contains($date,'+')">
            <xsl:text>+</xsl:text>
            <xsl:value-of select="substring-after($date, '+')"/>
          </xsl:when>
          <xsl:when test="contains($date,'-')">
            <xsl:text>-</xsl:text>
            <xsl:value-of select="substring-after($date, '-')"/>
          </xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:choose>
        <!-- reference: http://www.timeanddate.com/library/abbreviations/timezones/na/ -->
        <xsl:when test="$tzon = '-0500' ">
          <xsl:text>, EST</xsl:text>
        </xsl:when>
        <xsl:when test="$tzon = '-0600' ">
          <xsl:text>, CST</xsl:text>
        </xsl:when>
        <xsl:when test="$tzon = '-0700' ">
          <xsl:text>, MST</xsl:text>
        </xsl:when>
        <xsl:when test="$tzon = '-0800' ">
          <xsl:text>, PST</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text> </xsl:text>
          <xsl:value-of select="$tzon"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  <!-- convert to lower case -->
  <xsl:template name="caseDown">
    <xsl:param name="data"/>
    <xsl:if test="$data">
      <xsl:value-of select="translate($data, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
    </xsl:if>
  </xsl:template>
  <!-- convert to upper case -->
  <xsl:template name="caseUp">
    <xsl:param name="data"/>
    <xsl:if test="$data">
      <xsl:value-of select="translate($data,'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
    </xsl:if>
  </xsl:template>
  <!-- convert first character to upper case -->
  <xsl:template name="firstCharCaseUp">
    <xsl:param name="data"/>
    <xsl:if test="$data">
      <xsl:call-template name="caseUp">
        <xsl:with-param name="data" select="substring($data,1,1)"/>
      </xsl:call-template>
      <xsl:value-of select="substring($data,2)"/>
    </xsl:if>
  </xsl:template>
  <!-- show-noneFlavor -->
  <xsl:template name="show-noneFlavor">
    <xsl:param name="nf"/>
    <xsl:choose>
      <xsl:when test=" $nf = 'NI' ">
        <xsl:text>no information</xsl:text>
      </xsl:when>
      <xsl:when test=" $nf = 'INV' ">
        <xsl:text>invalid</xsl:text>
      </xsl:when>
      <xsl:when test=" $nf = 'MSK' ">
        <xsl:text>masked</xsl:text>
      </xsl:when>
      <xsl:when test=" $nf = 'NA' ">
        <xsl:text>not applicable</xsl:text>
      </xsl:when>
      <xsl:when test=" $nf = 'UNK' ">
        <xsl:text>unknown</xsl:text>
      </xsl:when>
      <xsl:when test=" $nf = 'OTH' ">
        <xsl:text>other</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="addCSS">
    <style type="text/css">
      <xsl:text>
body {
  color: #003366;
  background-color: #FFFFFF;
  font-family: Verdana, Tahoma, sans-serif;
  font-size: 11px;
}

a {
  color: #003366;
  background-color: #FFFFFF;
}

h1 {
  font-size: 12pt;
  font-weight: bold;
}

h2 {
  font-size: 11pt;
  font-weight: bold;
}

h3 {
  font-size: 10pt;
  font-weight: bold;
}

h4 {
  font-size: 8pt;
  font-weight: bold;
}

div {
  width: 80%;
}

table {
  line-height: 10pt;
  width: 80%;
}

tr {
  background-color: #ccccff;
}

td {
  padding: 0.1cm 0.2cm;
  vertical-align: top;
}

.h1center {
  font-size: 12pt;
  font-weight: bold;
  text-align: center;
  width: 80%;
}

.header_table{
  border: 1pt inset #00008b;
}

.narr_table {
  width: 100%;
}

.narr_tr {
  background-color: #ffffcc;
}

.narr_th {
  background-color: #ffd700;
}

.td_label{
  font-weight: bold;
  color: #000000;
}
          </xsl:text>
    </style>
  </xsl:template>
</xsl:stylesheet>

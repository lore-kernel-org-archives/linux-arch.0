Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]:60646 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759654AbXF1JPQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jun 2007 05:15:16 -0400
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by netops-testserver-4.corp.sgi.com (Postfix) with SMTP id A609661B3D
	for <linux-arch@vger.kernel.org>; Thu, 28 Jun 2007 02:15:13 -0700 (PDT)
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id TAA02705 for <linux-arch@vger.kernel.org>; Thu, 28 Jun 2007 19:15:10 +1000
Received: from kao2.melbourne.sgi.com (localhost [127.0.0.1])
	by kao2.melbourne.sgi.com (Postfix) with ESMTP id BFEE314038B
	for <linux-arch@vger.kernel.org>; Thu, 28 Jun 2007 19:15:10 +1000 (EST)
From: Keith Owens <kaos@ocs.com.au>
Subject: CONFIG_TRACE_IRQFLAGS or CONFIG_TRACE_IRQFLAGS_SUPPORT?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jun 2007 19:15:10 +1000
Message-ID: <13566.1183022110@kao2.melbourne.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Arch code tests CONFIG_TRACE_IRQFLAGS, but the kconfig files define
CONFIG_TRACE_IRQFLAGS_SUPPORT.  Which is correct?


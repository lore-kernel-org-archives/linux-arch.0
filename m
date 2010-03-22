Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:11108 "EHLO
	demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049Ab0CVD2J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 21 Mar 2010 23:28:09 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Questions about SMP bootup control
Date: Mon, 22 Mar 2010 10:46:32 +0800
Message-ID: <2234BBB33B4B2048B28E3B3ACFC9795C01B53251@CNBEEXC007.nsn-intra.net>
In-Reply-To: <1269225435.8599.70.camel@pasglop>
References: <1269155601-18247-1-git-send-email-yinghai@kernel.org> <1269155601-18247-7-git-send-email-yinghai@kernel.org> <1269225435.8599.70.camel@pasglop>
From: "Zhu, Yijun (NSN - CN/Beijing)" <yijun.zhu@nsn.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20100322024632.kUgBp5MgcOTNtwFds2IMTW-X0IrskOEXzhaifbuCFGM@z>

Hi All:

I want to do some modification on the SMP architecture.

Purpose:
Only the first CPU is running the linux OS, while others do some private
services processing.

My solution:
In the end of the start_secondary() function, I try to schedu the slave
cpu to call my private endless loop instead of cpu_idle();

Result:
The system can NOT up, there is no interactive cli.

Question:
Is there some wrong with my modification or I go to the wrong way?

Thank you very much.

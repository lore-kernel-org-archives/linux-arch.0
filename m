Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([192.83.249.54]:55179 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbXGJSeD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jul 2007 14:34:03 -0400
Message-ID: <4693D10D.8010502@zytor.com>
Date: Tue, 10 Jul 2007 11:33:49 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [x86 setup 17/33] A20 handling code
References: <11840359321823-git-send-email-hpa@zytor.com> <11840360383913-git-send-email-hpa@zytor.com> <11840361432207-git-send-email-hpa@zytor.com> <11840362483663-git-send-email-hpa@zytor.com> <11840363531039-git-send-email-hpa@zytor.com> <11840364593068-git-send-email-hpa@zytor.com> <1184036564610-git-send-email-hpa@zytor.com> <11840366692770-git-send-email-hpa@zytor.com> <11840367741994-git-send-email-hpa@zytor.com> <11840368791603-git-send-email-hpa@zytor.com> <11840369841576-git-send-email-hpa@zytor.com> <11840370903975-git-send-email-hpa@zytor.com> <11840371953778-git-send-email-hpa@zytor.com> <11840373002601-git-send-email-hpa@zytor.com> <11840374052662-git-send-email-hpa@zytor.com> <1184037510289-git-send-email-hpa@zytor.com> <11840376162370-git-send-email-hpa@zytor.com> <11840377211519-git-send-email-hpa@zytor.com> <Pine.LNX.4.64.0707102025390.11053@fbirervta.pbzchgretzou.qr>
In-Reply-To: <Pine.LNX.4.64.0707102025390.11053@fbirervta.pbzchgretzou.qr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, andi@firstfloor.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

Jan Engelhardt wrote:
> On Jul 9 2007 19:51, H. Peter Anvin wrote:
> 
>> +		status = inb(0x64);
>> +		if (status & 1) {
>> +			/* Read and discard input data */
>> +			io_delay();
>> +			(void)inb(0x60);
> 
> Is the (void) cast needed for some obscure reason? Let's hope inb _is_ declared
> as volatile. (Minus the volatile flames.
> 

The (void) cast is there as a stylistic device, it tells the human
reader "yes, I really meant to read this value and throw it away."

	-hpa


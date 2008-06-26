Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59983 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbYFZSCJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jun 2008 14:02:09 -0400
Message-ID: <4863D7E3.1030705@zytor.com>
Date: Thu, 26 Jun 2008 10:54:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: Microblaze init port v4
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz> <200806261709.37045.arnd@arndb.de> <200806261951.12809.arnd@arndb.de>
In-Reply-To: <200806261951.12809.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: monstr@seznam.cz, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk
Message-ID: <20080626175443.87GUdSx-agTaa6C-TFIIXakVFUxeIJs_hcDaLewZD7U@z>

Arnd Bergmann wrote:
> 
> * You are using sys_ipc and sys_socketcall instead of the
> broken-out syscalls, which is a direct consequence of following
> the i386 numbering scheme.
> 

Please pretty please kill, kill, kill...

	-hpa

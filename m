From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 60/60] microblaze_v4: Enable drivers for Microblaze
Date: Thu, 26 Jun 2008 16:16:39 +0200
Message-ID: <87d4m4i8mw.fsf@macbook.be.48ers.dk>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-42-git-send-email-monstr@seznam.cz>
	<1214483429-32360-43-git-send-email-monstr@seznam.cz>
	<1214483429-32360-44-git-send-email-monstr@seznam.cz>
	<1214483429-32360-45-git-send-email-monstr@seznam.cz>
	<1214483429-32360-46-git-send-email-monstr@seznam.cz>
	<1214483429-32360-47-git-send-email-monstr@seznam.cz>
	<1214483429-32360-48-git-send-email-monstr@seznam.cz>
	<1214483429-32360-49-git-send-email-monstr@seznam.cz>
	<1214483429-32360-50-git-send-email-monstr@seznam.cz>
	<1214483429-32360-51-git-send-email-monstr@seznam.cz>
	<1214483429-32360-52-git-send-email-monstr@seznam.cz>
	<1214483429-32360-53-git-send-email-monstr@seznam.cz>
	<1214483429-32360-54-git-send-email-monstr@seznam.cz>
	<1214483429-32360-55-git-send-email-monstr@seznam.cz>
	<1214483429-32360-56-git-send-email-monstr@seznam.cz>
	<1214483429-32360-57-git-send-email-monstr@seznam.cz>
	<1214483429-32360-58-git-send-email-monstr@seznam.cz>
	<1214483429-32360-59-git-send-email-monstr@seznam.cz>
	<1214483429-32360-60-git-send-email-monstr@seznam.cz>
	<1214483429-32360-61-git-send-email-monstr@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:29469 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbYFZORZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jun 2008 10:17:25 -0400
Received: by gv-out-0910.google.com with SMTP id e6so10381gvc.37
        for <linux-arch@vger.kernel.org>; Thu, 26 Jun 2008 07:17:23 -0700 (PDT)
In-Reply-To: <1214483429-32360-61-git-send-email-monstr@seznam.cz> (monstr@seznam.cz's message of "Thu\, 26 Jun 2008 14\:30\:29 +0200")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk, Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com, arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au, drepper@redhat.com, linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com, John.Linn@xilinx.com, john.williams@petalogix.com

>>>>> "monstr" == monstr  <monstr@seznam.cz> writes:

 monstr> From: Michal Simek <monstr@monstr.eu>
 monstr> Signed-off-by: Michal Simek <monstr@monstr.eu>

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

 monstr>  config SERIAL_UARTLITE
 monstr>  	tristate "Xilinx uartlite serial port support"
 monstr> -	depends on PPC32
 monstr> +	depends on PPC32 || MICROBLAZE
 monstr>  	select SERIAL_CORE
 monstr>  	help

-- 
Bye, Peter Korsgaard

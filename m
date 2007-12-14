Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:55391 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbXLNSFO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Dec 2007 13:05:14 -0500
Message-ID: <4762C451.7020601@zytor.com>
Date: Fri, 14 Dec 2007 09:58:41 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH REVISED] Avoid overflows in kernel/time.c
References: <200712140113.lBE1DJvS000316@tazenda.hos.anvin.org> <20071214081033.GA17598@uranus.ravnborg.org>
In-Reply-To: <20071214081033.GA17598@uranus.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>

Sam Ravnborg wrote:
> 
> I understood that bc is unreliable.
> How about creating a small .c program that does to necessary computation
> and integrate it in the build process.
> It should be much cleaner than this approach.
> 

You'd have to include an extended-precision library in said C program.

	-hpa

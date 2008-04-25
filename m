Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:46912 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757939AbYDYS1y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Apr 2008 14:27:54 -0400
Date: Fri, 25 Apr 2008 20:27:53 +0200 (CEST)
From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
In-Reply-To: <1209078352-7593-3-git-send-email-hpa@zytor.com>
Message-ID: <alpine.LNX.1.10.0804252026040.20150@fbirervta.pbzchgretzou.qr>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com> <1209078352-7593-3-git-send-email-hpa@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>
Message-ID: <20080425182753.lEH-_lfi-_3TDXf_GxuUn0dAu9GYFm-vP1-GJ2bz8hQ@z>


On Friday 2008-04-25 01:05, H. Peter Anvin wrote:

>This creates two generic files with common integer definitions; one
>where 64 bits is "long" (most 64-bit architectures) and one where 64
>bits is "long long" (all 32-bit architectures and x86-64.)

long long is 64 bits on both 32 and 64, is not it?
If so, the split between 32 and 64 should not be necessary.


Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:42984 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423AbYDNKcj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Apr 2008 06:32:39 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1207950449.22001.106.camel@brick>
References: <1207950449.22001.106.camel@brick>
Subject: Re: [PATCHv3 2/2] kernel: Move arches to use common unaligned access
Date: Mon, 14 Apr 2008 11:32:09 +0100
Message-ID: <4392.1208169129@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: dhowells@redhat.com, Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20080414103209.SiHyg3Mx3qU9Pm1WsACDZV5wyF3mU5aP_Quf8b6NGf0@z>

Harvey Harrison <harvey.harrison@gmail.com> wrote:

> -#ifndef _ASM_UNALIGNED_H
> -#define _ASM_UNALIGNED_H
> +#ifndef _ASM_FRV_UNALIGNED_H_
> +#define _ASM_FRV_UNALIGNED_H_

Please don't.  Why do you need to change these to make your patch work?

> -extern int handle_misalignment(unsigned long esr0, unsigned long ear0, unsigned long epcr0);

Don't lose this please, not unless you're going to erase the
handle_misalignment() function and remove the refs to it.

David

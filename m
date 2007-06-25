Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from scrub.xs4all.nl ([194.109.195.176]:3870 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755786AbXFYPSa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Jun 2007 11:18:30 -0400
Date: Mon, 25 Jun 2007 17:18:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] cross-architecture ELF clean up
In-Reply-To: <20070620230902.387008536@goop.org>
Message-ID: <Pine.LNX.4.64.0706251714410.4386@scrub.home>
References: <20070620230854.246399397@goop.org> <20070620230902.387008536@goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Arch <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Hi,

On Wed, 20 Jun 2007, Jeremy Fitzhardinge wrote:

> 	linux/elf-const.h	- ELF constants, includable by asm code

BTW who's the maniac who tries to use this in asm code?
Many of these constants are pretty useless without the corresponding 
structure definitions.

bye, Roman

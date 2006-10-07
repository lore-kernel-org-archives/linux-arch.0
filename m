Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from scrub.xs4all.nl ([194.109.195.176]:35995 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932521AbWJGXzR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 Oct 2006 19:55:17 -0400
From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
Date: Sun, 8 Oct 2006 01:50:39 +0200
References: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610080150.41268.zippel@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi,

On Friday 06 October 2006 15:34, David Howells wrote:

> +config ARCH_HAS_ILOG2_U32
> +	bool
> +	default n

This actually doesn't do much, so you only have to add it, where it's 'y' 
and "def_bool y" is shorter there.

bye, Roman

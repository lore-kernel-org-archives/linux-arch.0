Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:44940 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S932359AbWJFORG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 6 Oct 2006 10:17:06 -0400
Date: Fri, 6 Oct 2006 08:17:04 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
Message-ID: <20061006141704.GH2563@parisc-linux.org>
References: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Oct 06, 2006 at 02:34:14PM +0100, David Howells wrote:
> +config ARCH_HAS_ILOG2_U32
> +	bool
> +	default n

Why not "def_bool n"?  Or indeed, since the default is n, why not just
"bool"?


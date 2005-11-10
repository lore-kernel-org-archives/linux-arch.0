Return-Path: <linux-arch-owner@vger.kernel.org>
From: Andi Kleen <ak@suse.de>
Subject: Re: irq-type-flags.patch
Date: Thu, 10 Nov 2005 15:06:39 +0100
References: <20051108191057.09f57114.akpm@osdl.org>
In-Reply-To: <20051108191057.09f57114.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511101506.39816.ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 09 November 2005 04:10, Andrew Morton wrote:
> Is everyone OK with this?
>

These flags will be nops on x86 and many other architectures. Could
be confusing to driver writers. Can this please be made clear in comments?

-Andi

>

Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 23 Feb 2005 20:02:21 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] set_pte() part 1 (was Re: [PATCH] ppc32: Wrong vaddr in
 flush_hash_one_pte())
Message-Id: <20050223200221.6c7d4174.davem@davemloft.net>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F02F5D4B4@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02F5D4B4@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "Luck, Tony" <tony.luck@intel.com>
Cc: benh@au1.ibm.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 23 Feb 2005 16:55:50 -0800
"Luck, Tony" <tony.luck@intel.com> wrote:

> >I've been over this a few times this afternoon and the patch looks
> >correct.  Please test the build and boot of your platform, any build
> >failures should be trivial typos and nothing major.
> 
> Builds (no new warnings) and boots on ia64.

Thanks for testing Tony.

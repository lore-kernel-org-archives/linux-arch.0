From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 05/37] ata: use get/put_endian helpers
Date: Thu, 29 May 2008 21:18:52 -0700
Message-ID: <1212121132.28403.182.camel@brick>
References: <1212092282.28403.107.camel@brick> <483F65CA.4050507@rtr.ca>
	 <20080529195225.5665ae9c.akpm@linux-foundation.org>
	 <18495.32327.521211.508818@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <18495.32327.521211.508818@cargo.ozlabs.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mark Lord <liml@rtr.ca>, linux-arch <linux-arch@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 2008-05-30 at 14:10 +1000, Paul Mackerras wrote:
> Andrew Morton writes:
> 
> > On Thu, 29 May 2008 22:26:18 -0400 Mark Lord <liml@rtr.ca> wrote:

> Plus we have a common idiom that get_*() functions increment some sort
> of reference count, and put_*() functions decrease a reference count
> and may free something...

Except for get_unaligned(), put_unaligned()

But point taken.

Harvey


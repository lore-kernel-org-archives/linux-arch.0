Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10427 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755566Ab3CLSWb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Mar 2013 14:22:31 -0400
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 1/4] UAPI: Fix endianness conditionals in linux/aio_abi.h
References: <20130306204724.31327.43118.stgit@warthog.procyon.org.uk>
	<20130306204733.31327.97388.stgit@warthog.procyon.org.uk>
	<20130312163207.GI8869@kvack.org>
Date: Tue, 12 Mar 2013 14:22:17 -0400
In-Reply-To: <20130312163207.GI8869@kvack.org> (Benjamin LaHaise's message of
	"Tue, 12 Mar 2013 12:32:07 -0400")
Message-ID: <x49boaov5pi.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, sfr@canb.auug.org.au, Joakim.Tjernlund@transmode.se, arnd@arndb.de, linux-aio@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Message-ID: <20130312182217.CsJiRWfqVQSRC7dc57rheqO62Txpnebflp6dGuYLx8o@z>

Benjamin LaHaise <bcrl@kvack.org> writes:

> On Wed, Mar 06, 2013 at 08:47:33PM +0000, David Howells wrote:
>> In the UAPI header files, __BIG_ENDIAN and __LITTLE_ENDIAN must be compared
>> against __BYTE_ORDER in preprocessor conditionals where these are exposed to
>> userspace (that is they're not inside __KERNEL__ conditionals).
>> 
>> However, in the main kernel the norm is to check for "defined(__XXX_ENDIAN)"
>> rather than comparing against __BYTE_ORDER and this has incorrectly leaked
>> into the userspace headers.
>> 
>> The definition of PADDED() in linux/aio_abi.h is wrong in this way.  Note that
>> userspace will likely interpret this and thus the order of fields in struct
>> iocb incorrectly as the little-endian variant on big-endian machines -
>> depending on header inclusion order.
>> 
>> [!!!] NOTE [!!!]  This patch may adversely change the userspace API.  It might
>> be better to fix the ordering of aio_key and aio_reserved1 in struct iocb.
>
> It is unlikely that anyone has used the existing kernel headers and hit this 
> issue given that most existing users use the libaio.h include (which does not 
> get the endianness tests wrong).  Given that the kernel has always used the 
> correct endian mappings, this change is correct.

Agreed.

Acked-by: Jeff Moyer <jmoyer@redhat.com>

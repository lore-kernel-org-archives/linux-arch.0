From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH 0/5] Bump gcc minimum version to 3.4, 4.1 for x86
Date: Wed, 15 Sep 2010 15:24:30 -0700
Message-ID: <4C91479E.3040208@zytor.com>
References: <1284408880-14414-1-git-send-email-hpa@linux.intel.com> <AANLkTi=JpfhvyxC13U98x5me9U8dU6BHOcGkPC0KK7aW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59136 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604Ab0IOWYd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2010 18:24:33 -0400
In-Reply-To: <AANLkTi=JpfhvyxC13U98x5me9U8dU6BHOcGkPC0KK7aW@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: "H. Peter Anvin" <hpa@linux.intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 09/13/2010 05:11 PM, Brian Gerst wrote:
> On Mon, Sep 13, 2010 at 4:14 PM, H. Peter Anvin <hpa@linux.intel.com> wrote:
>> This patchset bumps the minimum supported gcc version to 3.4 for the
>> general kernel, and to 4.1 for x86.
>>
>> We have had a rash of bug reports related to these really old
>> compilers and their associated binutils version lately, and it is
>> clear that the support burden of these older compilers is getting to
>> be excessive.  If you really want to build a kernel on a system that
>> old you can build or obtain an updated gcc/binutils as well.
> 
> What version of binutils does this correspond to?  It would be nice to
> clean up some of the hacks for ancient binutils as well.
> 

4.1 -> 2.16
3.4 -> 2.14/2.15 (gcc 3.4.0 beat binutils 2.15 by a mere 29 days)

This is somewhat unfortunate, since neither of these brackets eliminate
the Binutils Version From Hell, a.k.a. 2.16.

	-hpa

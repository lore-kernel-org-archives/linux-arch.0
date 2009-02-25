From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 14/15] bitops: Change the bitmap index from int to unsigned
 long [frv]
Date: Wed, 25 Feb 2009 14:33:56 -0800
Message-ID: <49A5C754.7000408@zytor.com>
References: <200902250452.UAA12902@hpdst41.cup.hp.com> <16693.1235565430@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:45441 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919AbZBYWkf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 17:40:35 -0500
In-Reply-To: <16693.1235565430@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Justin Chen <jchen@hpdst41.cup.hp.com>, linux-arch@vger.kernel.org, bjorn.helgaas@hp.com, justin.chen@hp.com, linux-kernel@vger.kernel.org

David Howells wrote:
> 
>> -static inline int __constant_test_bit(int nr, const volatile void * addr)
>> +static inline int
>> +__constant_test_bit(unsigned long nr, const volatile void *addr)
> 
> Please move the return type onto the next line also.  Other than that:
> 
> Acked-by: David Howells <dhowells@redhat.com>

What makes you say that, in particular?   A casual grep finds no less 
than 3524 instances of "static inline <type>" -- presumably with a 
function name following -- and only 447 instances of "static inline" 
without a type in the kernel.

	-hpa

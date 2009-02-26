From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 14/15] bitops: Change the bitmap index from int to unsigned
 long [frv]
Date: Wed, 25 Feb 2009 16:57:15 -0800
Message-ID: <49A5E8EB.6000409@zytor.com>
References: <49A5C754.7000408@zytor.com> <200902250452.UAA12902@hpdst41.cup.hp.com> <16693.1235565430@redhat.com> <7355.1235605851@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:36042 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbZBZBD5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 20:03:57 -0500
In-Reply-To: <7355.1235605851@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Justin Chen <jchen@hpdst41.cup.hp.com>, linux-arch@vger.kernel.org, bjorn.helgaas@hp.com, justin.chen@hp.com, linux-kernel@vger.kernel.org

David Howells wrote:
> 
>> A casual grep finds no less than 3524 instances of "static inline <type>" --
>> presumably with a function name following -- and only 447 instances of
>> "static inline" without a type in the kernel.
> 
> But how does it break down between "static inline type\nfunction_name" and
> "static inline\ntype function_name"?  That's more to the point.
> 

I believe that is the breakdown is roughly what you see above, i.e. over 
8:1; the pattern I used was looking for "^static inline[^;(]*$", and a 
visual examination of the results shows that even if my line count is 
slighly off the lopsidedness is still dramatic.

	-hpa

From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 14/15] bitops: Change the bitmap index from int to unsigned
 long [frv]
Date: Wed, 25 Feb 2009 17:43:55 -0800
Message-ID: <49A5F3DB.5000401@zytor.com>
References: <49A5E876.1000501@zytor.com> <49A5C754.7000408@zytor.com> <200902250452.UAA12902@hpdst41.cup.hp.com> <16693.1235565430@redhat.com> <7355.1235605851@redhat.com> <9679.1235612268@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:51076 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbZBZBud (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 20:50:33 -0500
In-Reply-To: <9679.1235612268@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Justin Chen <jchen@hpdst41.cup.hp.com>, linux-arch@vger.kernel.org, bjorn.helgaas@hp.com, justin.chen@hp.com, linux-kernel@vger.kernel.org

David Howells wrote:
> H. Peter Anvin <hpa@zytor.com> wrote:
> 
>>> But how does it break down between "static inline type\nfunction_name" and
>>> "static inline\ntype function_name"?  That's more to the point.
>>>
>> I believe that is the breakdown is roughly what you see above, i.e. over 8:1;
>> the pattern I used was looking for "^static inline[^;(]*$", and a visual
>> examination of the results shows that even if my line count is slighly off the
>> lopsidedness is still dramatic.
> 
> Sorry, I meant:
> 
> "static inline type\nfunction_name" vs "static inline type function_name"
> 

Well, the latter is obviously in vast majority, but that doesn't seem to 
have anything to do with anything at all here...

	-hpa

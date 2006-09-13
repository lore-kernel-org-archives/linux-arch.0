Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:24937 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750847AbWIMRyo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 13 Sep 2006 13:54:44 -0400
Message-ID: <450845CC.6000402@yahoo.com.au>
Date: Thu, 14 Sep 2006 03:54:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Why Semaphore Hardware-Dependent?
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <44F395DE.10804@yahoo.com.au> <200608290807.40963.ak@suse.de>
In-Reply-To: <200608290807.40963.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Dong Feng <middle.fengdong@gmail.com>, Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

[sorry, I missed some emails when I was out of action a while back. Catching up...]

Andi Kleen wrote:
>>and chuck out the "crappy" rwsem fallback implementation
> 
> 
> What is crappy with it?

I just mean that it is supposedly the second class implementation. Just
seems wrong when powerpc has implemented the "better" version in a completely
generic way (patch to follow).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

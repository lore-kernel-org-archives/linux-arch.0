Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1134558507.2894.22.camel@laptopd505.fenrus.org>
References: <439EDC3D.5040808@nortel.com>
	 <1134479118.11732.14.camel@localhost.localdomain>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
	 <15167.1134488373@warthog.cambridge.redhat.com>
	 <1134490205.11732.97.camel@localhost.localdomain>
	 <1134556187.2894.7.camel@laptopd505.fenrus.org>
	 <1134558188.25663.5.camel@localhost.localdomain>
	 <1134558507.2894.22.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Dec 2005 11:24:30 +0000
Message-Id: <1134559470.25663.22.camel@localhost.localdomain>
Mime-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mer, 2005-12-14 at 12:08 +0100, Arjan van de Ven wrote:
> 1) the BKL change hasn't finished, and we're 5 years down the line. API
> changes done gradual tend to take forever in practice, esp if there's no
> "compile" incentive for people to fix things. 

This isn't a "fix" however, its merely a performance tweak. Drivers
using the old API are not a problem because

a) The old API is needed long term for true counting sem users
b) Its a minor performance hit at most

Thats rather different to the BKL

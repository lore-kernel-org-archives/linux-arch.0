Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 14 Dec 2005 03:35:36 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <20051214033536.05183668.akpm@osdl.org>
In-Reply-To: <1134559470.25663.22.camel@localhost.localdomain>
References: <439EDC3D.5040808@nortel.com>
	<1134479118.11732.14.camel@localhost.localdomain>
	<dhowells1134431145@warthog.cambridge.redhat.com>
	<3874.1134480759@warthog.cambridge.redhat.com>
	<15167.1134488373@warthog.cambridge.redhat.com>
	<1134490205.11732.97.camel@localhost.localdomain>
	<1134556187.2894.7.camel@laptopd505.fenrus.org>
	<1134558188.25663.5.camel@localhost.localdomain>
	<1134558507.2894.22.camel@laptopd505.fenrus.org>
	<1134559470.25663.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: arjan@infradead.org, dhowells@redhat.com, cfriesen@nortel.com, torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Could someone please remind me why we're even discussing this, given that
mutex_down() is slightly more costly than current down(), and mutex_up() is
appreciably more costly than current up()?

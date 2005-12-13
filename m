Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 09:40:53 -0800
From: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <20051213094053.33284360.pj@sgi.com>
In-Reply-To: <20051213100015.GA32194@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	<20051212161944.3185a3f9.akpm@osdl.org>
	<20051213075441.GB6765@elte.hu>
	<20051213090219.GA27857@infradead.org>
	<20051213093949.GC26097@elte.hu>
	<20051213100015.GA32194@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: hch@infradead.org, akpm@osdl.org, dhowells@redhat.com, torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

If we are doing global rename patches, could we make one of the
deliverables a sed or perl script that exactly produces the patch,
suitable for running one-time on out-of-kernel trees?  Add the script
in the kernel scripts directory.

It is usually too easy to produce a nearly correct script, and too
difficult to produce an exactly right one, for all but serious sed or
perl regex hackers.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

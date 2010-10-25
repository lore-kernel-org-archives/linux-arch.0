From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH] Partially revert patch that encloses asm-offset.h
	 numbers in brackets
Date: Mon, 25 Oct 2010 16:29:39 +0100
Message-ID: <4CC5BE83020000780001EFE4@vpn.id2.novell.com>
References: <4CC5B1A1020000780001EF7C@vpn.id2.novell.com>
 <20101025140218.5092.74117.stgit@warthog.procyon.org.uk>
 <28707.1288018465@redhat.com>
 <4CC5B8D3020000780001EFB4@vpn.id2.novell.com>
 <AANLkTi=mpKRQgZp5zCoCsBtkuWHrpkOq2Zch-OOGu4CC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=mpKRQgZp5zCoCsBtkuWHrpkOq2Zch-OOGu4CC@mail.gmail.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Alexander van Heukelum <heukelum@fastmail.fm>, akpm@linux-foundation.org, "H. Peter Anvin" <hpa@linux.intel.com>, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

>>> On 25.10.10 at 17:17, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> How about just removing the idiotic workaround entirely, and then on
> x86 passing "-traditional" to cpp for asm input so that it doesn't add
> spaces in argument expansion? Make the workaround more targeted to the
> actual problem, rather than working around it in some unrelated
> thing..

Hmm, I think it was an actual improvement to remove the use of
-traditional. If fiddling with the globally used sed expression isn't
considered acceptable, how about allowing the architecture to
override it as necessary?

Jan

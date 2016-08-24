From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 0/3 v3] kbuild changes, thin archives, --gc-sections
Date: Wed, 24 Aug 2016 11:21:33 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1608241114430.17623@knanqh.ubzr>
References: <1472041761-14414-1-git-send-email-npiggin@gmail.com> <12110.1472048481@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <12110.1472048481@warthog.procyon.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 24 Aug 2016, David Howells wrote:

> Out of interest, does using LTO also fix the problem?

With those patches in place, that would be the next thing to try.
Reducing our reliance on 'ld -r' will greatly help promoting LTO for the
kernel.

Personally I'd like to have the choice between LTO and -gc-sections at 
configure time.  They both have advantages of their own.


Nicolas

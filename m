From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip v2 4/7] kprobes: Replace %p with other pointer
 types
Date: Thu, 26 Apr 2018 21:13:51 -0400
Message-ID: <20180426211351.419d3502@vmware.local.home>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
        <152473020349.8819.11597612324633031612.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <152473020349.8819.11597612324633031612.stgit@devbox>
Sender: stable-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 26 Apr 2018 17:10:03 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Replace %p with appropriate pointer types (or just remove it)
>  - Use %pS if possible
>  - Use %px only for the function right before BUG().
>  - Remove unneeded error message.

I'm not sure "right before BUG()" is legitimate for using %px. Why not
still use %pS?

-- Steve

From: Jan Engelhardt <jengelh-9+2X+4sQBs8@public.gmane.org>
Subject: Re: [opensuse-factory] Re: libsigsegv build fail
 with kernel 3.18.3
Date: Tue, 27 Jan 2015 22:12:07 +0100 (CET)
Message-ID: <alpine.LSU.2.11.1501272205130.3450@nerf60.vanv.qr>
References: <1422361485.6648.71.camel@opensuse.org> <54C78756.9090605@suse.cz> <alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr> <1422364084.6648.82.camel@opensuse.org> <s5h7fw8hvdp.wl-tiwai@suse.de>
 <CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <opensuse-kernel+bounces-6410-glsk-opensuse-kernel=m.gmane.org-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <mailto:opensuse-kernel-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:opensuse-kernel+help-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Subscribe: <mailto:opensuse-kernel+subscribe-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <mailto:opensuse-kernel+unsubscribe-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Owner: <mailto:opensuse-kernel+owner-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Archive: <http://lists.opensuse.org/opensuse-kernel/>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, opensuse-factory-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org, OpenSUSE Kernel Team <opensuse-kernel-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org


On Tuesday 2015-01-27 21:36, Linus Torvalds wrote:
>The only reason it returns SIGBUS is that we don't have an equivalent
>VM_FAULT_SIGSEGV error return.  Which is something of an oversight,
>but adding it is a pain too, simply because the callers are mainly the
>architecture page fault handlers, so the VM_FAULT_SIGSEGV handling has
>to be added to all of them.
>
>Very annoying. The patch would look something like the attached -
>TOTALLY UNTESTED.
>
>Does this fix things for you?

The 2nd patch (from 12:57:20 -0800) plus the one-liner for mm/memory.c
at the callsite for check_stack_guard_page makes the test still 
not succeed.

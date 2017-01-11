Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34285 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932406AbdAKTcF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Jan 2017 14:32:05 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so315474wmi.1
        for <linux-arch@vger.kernel.org>; Wed, 11 Jan 2017 11:32:04 -0800 (PST)
Date: Wed, 11 Jan 2017 22:32:01 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC, PATCHv2 29/29] mm, x86: introduce RLIMIT_VADDR
Message-ID: <20170111193201.GF4895@node.shutemov.name>
References: <5a3dcc25-b264-37c7-c090-09981b23940d@intel.com>
 <20170105192910.q26ozg4ci4i3j2ai@black.fi.intel.com>
 <161ece66-fbf4-cb89-3da6-91b4851af69f@intel.com>
 <CALCETrUQ2+P424d9MW-Dy2yQ0+EnMfBuY80wd8NkNmc8is0AUw@mail.gmail.com>
 <978d5f1a-ec4d-f747-93fd-27ecfe10cb88@intel.com>
 <20170111142904.GD4895@node.shutemov.name>
 <CALCETrUn=KNdOnoRYd8GcnXPNDHAhGkaMaHRTAri4o92FSC1qg@mail.gmail.com>
 <20170111183750.GE4895@node.shutemov.name>
 <0a6f1ee4-e260-ae7b-3d39-c53f6bed8102@intel.com>
 <CALCETrXDbkotCZ1WEbhNeYGt0zyKT42agzsFxT2SZJ4wadEnQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXDbkotCZ1WEbhNeYGt0zyKT42agzsFxT2SZJ4wadEnQA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
Message-ID: <20170111193201.4I9mJ0Kbp-HF6xhSYBXt5BrHP-zIkj4VrelOXuo18FM@z>

On Wed, Jan 11, 2017 at 11:20:38AM -0800, Andy Lutomirski wrote:
> On Wed, Jan 11, 2017 at 10:49 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> > On 01/11/2017 10:37 AM, Kirill A. Shutemov wrote:
> >>> How about preventing the max addr from being changed to too high a
> >>> value while MPX is on instead of overriding the set value?  This would
> >>> have the added benefit that it would prevent silent failures where you
> >>> think you've enabled large addresses but MPX is also on and mmap
> >>> refuses to return large addresses.
> >> Setting rlimit high doesn't mean that you necessary will get access to
> >> full address space, even without MPX in picture. TASK_SIZE limits the
> >> available address space too.
> >
> > OK, sure...  If you want to take another mechanism into account with
> > respect to MPX, we can do that.  We'd just need to change every
> > mechanism we want to support to ensure that it can't transition in ways
> > that break MPX.
> >
> > What are you arguing here, though?  Since we *might* be limited by
> > something else that we should not care about controlling the rlimit?
> >
> >> I think it's consistent with other resources in rlimit: setting RLIMIT_RSS
> >> to unlimited doesn't really means you are not subject to other resource
> >> management.
> >
> > The farther we get into this, the more and more I think using an rlimit
> > is a horrible idea.  Its semantics aren't a great match, and you seem to
> > be resistant to making *this* rlimit differ from the others when there's
> > an entirely need to do so.  We're already being bitten by "legacy"
> > rlimit.  IOW, being consistent with *other* rlimit behavior buys us
> > nothing, only complexity.
> 
> Taking a step back, I think it would be fantastic if we could find a
> way to make this work without any inheritable settings at all.
> Perhaps we could have a per-mm value that is initialized to 2^47-1 on
> execve() and can be raised by ELF note or by prctl()?

One thing that inheritance give us is ability to change available address
space from outside of binary. Both ELF note and prctl() doesn't really
work here.

Running legacy binary with full address space is valuable option.
As well as limiting address space for binary with ELF note or prctl() in
case of breakage in a field.

Sure, we can use personality(2) or invent other interface for this. But to
me rlimit covers both normal and emergency use-cases relatively well.

-- 
 Kirill A. Shutemov

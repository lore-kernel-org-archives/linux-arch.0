Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34523 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeEBVSX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 May 2018 17:18:23 -0400
Received: by mail-wm0-f48.google.com with SMTP id a137-v6so339326wme.1
        for <linux-arch@vger.kernel.org>; Wed, 02 May 2018 14:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180502132751.05B9F401F3041@oldenburg.str.redhat.com>
 <248faadb-e484-806f-1485-c34a72a9ca0b@intel.com> <822a28c9-5405-68c2-11bf-0c282887466d@redhat.com>
 <20180502211254.GA5863@ram.oc3035372033.ibm.com>
In-Reply-To: <20180502211254.GA5863@ram.oc3035372033.ibm.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 02 May 2018 21:18:11 +0000
Message-ID: <CALCETrUfO=vXg5rT-n=y8pLktcq5+ORvgpsOXCHG4GaugB3k2A@mail.gmail.com>
Subject: Re: [PATCH] pkeys: Introduce PKEY_ALLOC_SIGNALINHERIT and change
 signal semantics
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxram@us.ibm.com
Cc: Florian Weimer <fweimer@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, linux-x86_64@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>

On Wed, May 2, 2018 at 2:13 PM Ram Pai <linuxram@us.ibm.com> wrote:


> > Ram, would you please comment?

> on POWER the pkey behavior will remain the same at entry or at exit from
> the signal handler.  For eg:  if a key is read-disabled on entry into
> the signal handler, and gets read-enabled in the signal handler, than it
> will continue to be read-enabled on return from the signal handler.

> In other words, changes to key permissions persist across signal
> boundaries.

I don't know about POWER's ISA, but this is crappy behavior.  If a thread
temporarily grants itself access to a restrictive memory key and then gets
a signal, the signal handler should *not* have access to that key.

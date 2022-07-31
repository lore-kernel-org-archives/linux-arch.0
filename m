Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C386DC00140
	for <linux-arch@archiver.kernel.org>; Sun, 31 Jul 2022 22:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiGaWss (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 31 Jul 2022 18:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbiGaWsr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 31 Jul 2022 18:48:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A37BDEC4;
        Sun, 31 Jul 2022 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RI8A0xK5TJuBK1GyEsXxlodNADhnfabE70lKyHFKpiE=; b=ofmSXa53JAMaNO/0HX8mkIc/qR
        S/MHwLTW6BVlg8mhfYTkrzddljWJhtYgzYtebeXrvUy/yyTxYZNbjROGgfCvXe2v0J496W4UVy+L2
        nogBbZB5TBWXApI3HWLTsmlDn6cBkRtYdRa/Wo2jDwe5UN37JxYMG1z8UCXnHYHWxuG7UgeemsBKh
        l/nXfMW/SjsLQ9dI8AyK2NMIsmSjtO2bAs1/uDGEOyEsj87bq9+cU4SDdA/w/dOH381zBJ8hZrDUU
        q47cSGNPC1EBQepMAzuh7L4j4ArJhenUUXSms6lBgSTwX+wNPYqNi/r/wBbVF40pAvKBo/9wHP+Is
        7DjrVcKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oIHjc-006cww-Gr; Sun, 31 Jul 2022 22:48:32 +0000
Date:   Sun, 31 Jul 2022 23:48:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] make buffer_locked provide an acquire semantics
Message-ID: <YucGwGr4KTPPxbYJ@casper.infradead.org>
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <20220731173011.GX2860372@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220731173011.GX2860372@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 31, 2022 at 10:30:11AM -0700, Paul E. McKenney wrote:
> That said, I confess that I am having a hard time finding the
> buffer_locked() definition.  So if buffer_locked() uses normal C-language
> accesses to sample the BH_Lock bit of the ->b_state field, then yes,
> there could be a problem.  The compiler would then be free to reorder
> calls to buffer_locked() because it could then assume that no other
> thread was touching that ->b_state field.

You're having a hard time finding it because it's constructed with the C
preprocessor.  I really wish we generated header files using CPP once
and then included the generated/ file.  That would make them greppable.

You're looking for include/linux/buffer_head.h and it's done like this:

enum bh_state_bits {
...
        BH_Lock,        /* Is locked */
...

#define BUFFER_FNS(bit, name)                                           \
...
static __always_inline int buffer_##name(const struct buffer_head *bh)  \
{                                                                       \
        return test_bit(BH_##bit, &(bh)->b_state);                      \
}

BUFFER_FNS(Lock, locked)

(fwiw, the page/folio versions of these functions don't autogenerate
the lock or uptodate ones because they need extra functions called)

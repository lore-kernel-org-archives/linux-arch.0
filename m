Return-Path: <SRS0=vwiE=C5=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EAAC43465
	for <linux-arch@archiver.kernel.org>; Sun, 20 Sep 2020 18:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9546820874
	for <linux-arch@archiver.kernel.org>; Sun, 20 Sep 2020 18:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600625056;
	bh=NSRYiNc2jKHmT3zUkKKjemi40xx1ilPHq3p/aWreGe4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ftTwTgDVwi+w3vPWlV4/LdAgGM86oeUTszVfbfegyIZZeGRYnnW8LJjAQvgyEOzID
	 to93PJMDbAi2SEfj3tl0LFzghZ1VYuyVhqmIbawHLkxCPmqNFNTmlAnLRnDkKkQfy1
	 YUIFURtdfbNgclfHQkR7HiRx5QdJkAWbRSnr/UiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgITSEQ (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 20 Sep 2020 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgITSEQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Sep 2020 14:04:16 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E5CC061755
        for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2020 11:04:15 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w1so10724307edr.3
        for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2020 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10vFh59zX+qrXR+btNd9keaZllR85H50W0pZVqW9mvg=;
        b=aTcZkpnkgiAVVoqRXBCAnYw8B8YS7QD0nmh7mtbe8Dtb85AdAYIiPcbXVjdrb/fbX9
         3yTs920flMKnlnbAGz7q1CYoJs0994Dvfor1DakKOqSDUOemiqgeakXoqfK/+swxI5fB
         0DUfGVYXrHTR7XO61iz2Eybc+W0Ekg5v+dkh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10vFh59zX+qrXR+btNd9keaZllR85H50W0pZVqW9mvg=;
        b=jAbquRw3/+attr8nuvA9Hp/MEYuk7XzM/dqy+tSgS+JwkjWAz8WoEko+SNXZ1LhRtG
         JYvQdzoAxEjaueYYdi09jc+o5AJtQ+vOy3i/Ko2ftCxlR5BEtK2Yrzc4PDR19h2/jfeG
         RxQ+jN5eafOdjNSVDxJ+lM2lBoFkeFzUwKrahEREz8jXKpMbzN5WgNxSLx1Hm8JNO0ga
         3XUUNo7rcizNmqFJmvYldn4zX4cmKPadwU0bShiJL+PmaYh0cC6QcdH1EtUAe0IbaHzw
         nNvVFbXr4f0u09wWmCE31rzoZeaoUf4YjJ77i9IOOC7Cr4fY1Ogm8oxtx27nLs6HNsaa
         AI8g==
X-Gm-Message-State: AOAM533bH0mYDu393Y9E5ZgQOt7+jGJ1tfj0FoczjzKvTiagk6By+qxQ
        JITvVOD4JoexrwKj+owqtQwWnEzxVOK0JQ==
X-Google-Smtp-Source: ABdhPJwbn7uU2Oj5wZwpJc5hpIMKefDXJd4Y+KCsYalM+4fv6vBl59AASbEw8DVwCAC7tIgo+GXTQA==
X-Received: by 2002:a50:f102:: with SMTP id w2mr49804467edl.63.1600625054134;
        Sun, 20 Sep 2020 11:04:14 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id j15sm7075376ejs.5.2020.09.20.11.04.13
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 11:04:13 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id p9so14675184ejf.6
        for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2020 11:04:13 -0700 (PDT)
X-Received: by 2002:ac2:4ec7:: with SMTP id p7mr12591149lfr.352.1600624746105;
 Sun, 20 Sep 2020 10:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200919091751.011116649@linutronix.de> <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com>
 <87mu1lc5mp.fsf@nanos.tec.linutronix.de> <87k0wode9a.fsf@nanos.tec.linutronix.de>
 <CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw@mail.gmail.com>
 <87eemwcpnq.fsf@nanos.tec.linutronix.de> <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Sep 2020 10:58:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_iVgA3H7CVvAzDoYC1gC1AKbLmv_mCeUnVxg79_9y8A@mail.gmail.com>
Message-ID: <CAHk-=wh_iVgA3H7CVvAzDoYC1gC1AKbLmv_mCeUnVxg79_9y8A@mail.gmail.com>
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of
 kmap_atomic & friends
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vineet Gupta <vgupta@synopsys.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sparc <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 20, 2020 at 10:42 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yeah, that looks much easier to explain. Ack.

Btw, one thing that might be a good idea at least initially is to add
a check for p->kmap_ctrl.idx being zero at fork, exit and maybe
syscall return time (but that last one may be too cumbersome to really
worry about).

The kmap_atomic() interface basically has a lot of coverage for leaked
as part of all the "might_sleep()" checks sprinkled around,  The new
kmap_temporary/local/whatever wouldn't have that kind of incidental
debug checking, and any leaked kmap indexes would be rather hard to
debug (much) later when they cause index overflows or whatever.

                Linus

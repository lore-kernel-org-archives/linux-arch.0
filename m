Return-Path: <SRS0=XOKs=3M=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37842 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgAWR7Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 12:59:24 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so3018883lfc.4
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 09:59:23 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id i1sm1668982lji.71.2020.01.23.09.59.19
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 09:59:19 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id n18so4555946ljo.7
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 09:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20200123153341.19947-1-will@kernel.org>
In-Reply-To: <20200123153341.19947-1-will@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Jan 2020 09:59:03 -0800
Message-ID: <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
Message-ID: <20200123175903.z3AkyHRvm1ZjM4zx1laLr8adc_tniNA9nI32jYQuAO8@z>

On Thu, Jan 23, 2020 at 7:33 AM Will Deacon <will@kernel.org> wrote:
>
> This is version two of the patches I previously posted as an RFC here:

Looks fine to me, as far as I can tell,

              Linus

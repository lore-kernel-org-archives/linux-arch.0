Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752263AbeFYQJy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Jun 2018 12:09:54 -0400
Received: from mail-wr0-f172.google.com (mail-wr0-f172.google.com [209.85.128.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3C1025DDF
        for <linux-arch@vger.kernel.org>; Mon, 25 Jun 2018 16:09:53 +0000 (UTC)
Received: by mail-wr0-f172.google.com with SMTP id c13-v6so4310066wrq.2
        for <linux-arch@vger.kernel.org>; Mon, 25 Jun 2018 09:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180625140754.GB29102@dhcp22.suse.cz>
In-Reply-To: <20180625140754.GB29102@dhcp22.suse.cz>
From: Rob Herring <robh@kernel.org>
Date: Mon, 25 Jun 2018 10:09:41 -0600
Message-ID: <CABGGisyVpfYCz7-5AGB-3Ld9hcuikPVk=19xPc1AwffjhsV+kg@mail.gmail.com>
Subject: Re: why do we still need bootmem allocator?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mhocko@kernel.org
Cc: linux-mm@kvack.org, hannes@cmpxchg.org, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180625160941.apZtd7XKmiRW8c_K4sKXArFqfShFzpywks5TcNbbXPE@z>

On Mon, Jun 25, 2018 at 8:08 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> Hi,
> I am wondering why do we still keep mm/bootmem.c when most architectures
> already moved to nobootmem. Is there any fundamental reason why others
> cannot or this is just a matter of work?

Just because no one has done the work. I did a couple of arches
recently (sh, microblaze, and h8300) mainly because I broke them with
some DT changes.

> Btw. what really needs to be
> done? Btw. is there any documentation telling us what needs to be done
> in that regards?

No. The commits converting the arches are the only documentation. It's
a bit more complicated for platforms that have NUMA support.

Rob

From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [RFC v2 21/37] lkl tools: "boot" test
Date: Mon, 2 Mar 2020 14:25:35 -0800
Message-ID: <CAFd5g44+PD9FM6Vhy2uFAkSvgsOdxjy2gcP6duBzuhJGJaddgg@mail.gmail.com>
References: <fb0fcf4ffddaabc7eae82e25d7ec5ea9c37eb2ae.1573179553.git.thehajime@gmail.com>
 <20200123193315.132434-1-brendanhiggins@google.com> <20200302195116.GF11244@42.do-not-panic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f177.google.com ([209.85.210.177]:47033 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgCBWZr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 17:25:47 -0500
Received: by mail-pf1-f177.google.com with SMTP id o24so383454pfp.13
        for <linux-arch@vger.kernel.org>; Mon, 02 Mar 2020 14:25:47 -0800 (PST)
In-Reply-To: <20200302195116.GF11244@42.do-not-panic.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: KUnit Development <kunit-dev@googlegroups.com>, Hajime Tazaki <thehajime@gmail.com>, Octavian Purdila <tavi.purdila@gmail.com>, David Gow <davidgow@google.com>, Aleksa Sarai <cyphar@cyphar.com>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, Patrick Collins <pscollins@google.com>, Conrad Meyer <cem@freebsd.org>, Motomu Utsumi <motomuman@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Akira Moroo <retrage01@gmail.com>, Petros Angelatos <petrosagg@gmail.com>, Yuan Liu <liuyuan@google.com>, Thomas Liebetraut <thomas@tommie-lie.de>, Mark Stillwell <mark@stillwell.me>, David Disseldorp <ddiss@suse.de>, linux-kernel-library@freelists.org, Luca Dariz <luca.dariz@gmail.com>

On Mon, Mar 2, 2020 at 11:51 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Jan 23, 2020 at 11:33:15AM -0800, Brendan Higgins wrote:
> > Luis,
> >
> > Does this kind of match what you were thinking with the syscall testing?
>
> Without looking too deeply into the code, it seems to be the case.
> Are you going to expose / port kunit to tools/ to allow usersapace
> to run kunit tests?

Yes, I am thinking about this as a distinct possibility. I think it
only really makes sense in the context of syscall testing, probably
via LKL (assuming this works), but for general end-to-end testing, I
think kselftest has that area covered and users would be better served
by just integrating KUnit with kselftest.

> > In any case, I am excited about this. Please keep me posted in the
> > future!
>
> Yes please Cc me too.
>
>   Luis

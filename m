From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC v2 21/37] lkl tools: "boot" test
Date: Mon, 2 Mar 2020 19:51:16 +0000
Message-ID: <20200302195116.GF11244@42.do-not-panic.com>
References: <fb0fcf4ffddaabc7eae82e25d7ec5ea9c37eb2ae.1573179553.git.thehajime@gmail.com>
 <20200123193315.132434-1-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44354 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgCBTvT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 14:51:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so191198plo.11
        for <linux-arch@vger.kernel.org>; Mon, 02 Mar 2020 11:51:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200123193315.132434-1-brendanhiggins@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Cc: kunit-dev@googlegroups.com, Hajime Tazaki <thehajime@gmail.com>, Octavian Purdila <tavi.purdila@gmail.com>, David Gow <davidgow@google.com>, Aleksa Sarai <cyphar@cyphar.com>, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, Patrick Collins <pscollins@google.com>, Conrad Meyer <cem@FreeBSD.org>, Motomu Utsumi <motomuman@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Akira Moroo <retrage01@gmail.com>, Petros Angelatos <petrosagg@gmail.com>, Yuan Liu <liuyuan@google.com>, Thomas Liebetraut <thomas@tommie-lie.de>, Mark Stillwell <mark@stillwell.me>, David Disseldorp <ddiss@suse.de>, linux-kernel-library@freelists.org, Luca Dariz <luca.dariz@gmail.com>

On Thu, Jan 23, 2020 at 11:33:15AM -0800, Brendan Higgins wrote:
> Luis,
> 
> Does this kind of match what you were thinking with the syscall testing?

Without looking too deeply into the code, it seems to be the case.
Are you going to expose / port kunit to tools/ to allow usersapace
to run kunit tests?

> In any case, I am excited about this. Please keep me posted in the
> future!

Yes please Cc me too.

  Luis

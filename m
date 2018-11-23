Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2632797AbeKXCwG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Nov 2018 21:52:06 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B9BC20878
        for <linux-arch@vger.kernel.org>; Fri, 23 Nov 2018 16:07:17 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id r63-v6so12419548wma.4
        for <linux-arch@vger.kernel.org>; Fri, 23 Nov 2018 08:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20181112142654.341-1-cyphar@cyphar.com> <20181112142654.341-3-cyphar@cyphar.com>
 <1ce83cdf6e3168350b69f98f08aaa202bbaa682d.camel@bitron.ch>
In-Reply-To: <1ce83cdf6e3168350b69f98f08aaa202bbaa682d.camel@bitron.ch>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 23 Nov 2018 08:07:03 -0800
Message-ID: <CALCETrURCXjNMBR6DjujVc6HHHS=CbET81kHS+odur+Bm-z7Tg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] namei: O_BENEATH-style path resolution flags
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: j@bitron.ch
Cc: Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Christian Brauner <christian@brauner.io>, Linux API <linux-api@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>, David Drysdale <drysdale@google.com>, Aleksa Sarai <asarai@suse.de>, Linux Containers <containers@lists.linux-foundation.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20181123160703.SWKQGJF3-WSJkz-666u6RxlVEOinKcsouLdCCwSJ3E4@z>

> On Nov 23, 2018, at 5:10 AM, J=C3=BCrg Billeter <j@bitron.ch> wrote:
>
> Hi Aleksa,
>
>> On Tue, 2018-11-13 at 01:26 +1100, Aleksa Sarai wrote:
>> * O_BENEATH: Disallow "escapes" from the starting point of the
>>  filesystem tree during resolution (you must stay "beneath" the
>>  starting point at all times). Currently this is done by disallowing
>>  ".." and absolute paths (either in the given path or found during
>>  symlink resolution) entirely, as well as all "magic link" jumping.
>
> With open_tree(2) and OPEN_TREE_CLONE, will O_BENEATH still be
> necessary?

This discussion reminds me of something I=E2=80=99m uncomfortable with in t=
he
current patches: currently, most of the O_ flags determine some
property of the returned opened file.  The new O_ flags you're adding
don't -- instead, they affect the lookup of the file.  So O_BENEATH
doesn't return a descriptor that can only be used to loop up files
beneath it -- it just controls whether open(2) succeeds or fails.  It
might be nice for the naming of the flags to reflect this.  I also
don't love that we have some magic AT_ flags that work with some
syscalls and some magic O_ flags that work with others.

In this regard, I liked the AT_ naming better.  Although I don't love
adding AT_ flags because the restrict our ability to usefully use the
high bits of the fd in the future.

--Andy

From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v6] fs: clear file privilege bits when mmap writing
Date: Mon, 11 Jan 2016 11:38:32 -0800
Message-ID: <CAGXu5jJaoZC7WL=MndBr915XhEpn9n3HOOhB-ue1xqyKFWxxzQ@mail.gmail.com>
References: <20160108232727.GA23490@www.outflux.net>
	<CALYGNiOUL7ewU3+5Zoi_9qofYWwF0vpqMy=A0wS=jUFZ11haCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35447 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933284AbcAKTid (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jan 2016 14:38:33 -0500
Received: by mail-io0-f176.google.com with SMTP id 77so328696921ioc.2
        for <linux-arch@vger.kernel.org>; Mon, 11 Jan 2016 11:38:33 -0800 (PST)
In-Reply-To: <CALYGNiOUL7ewU3+5Zoi_9qofYWwF0vpqMy=A0wS=jUFZ11haCg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@amacapital.net>, Jan Kara <jack@suse.cz>, yalin wang <yalin.wang2010@gmail.com>, Willy Tarreau <w@1wt.eu>, Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kern>, "linux-mm@kvack.org" <linux-mm@kvack.org>

On Sun, Jan 10, 2016 at 7:48 AM, Konstantin Khlebnikov <koct9i@gmail.com> wrote:
> On Sat, Jan 9, 2016 at 2:27 AM, Kees Cook <keescook@chromium.org> wrote:
>> Normally, when a user can modify a file that has setuid or setgid bits,
>> those bits are cleared when they are not the file owner or a member
>> of the group. This is enforced when using write and truncate but not
>> when writing to a shared mmap on the file. This could allow the file
>> writer to gain privileges by changing a binary without losing the
>> setuid/setgid/caps bits.
>>
>> Changing the bits requires holding inode->i_mutex, so it cannot be done
>> during the page fault (due to mmap_sem being held during the fault). We
>> could do this during vm_mmap_pgoff, but that would need coverage in
>> mprotect as well, but to check for MAP_SHARED, we'd need to hold mmap_sem
>> again. We could clear at open() time, but it's possible things are
>> accidentally opening with O_RDWR and only reading. Better to clear on
>> close and error failures (i.e. an improvement over now, which is not
>> clearing at all).
>
> I think this should be done in mmap/mprotect. Code in sys_mmap is trivial.
>
> In sys_mprotect you can check file_needs_remove_privs() and VM_SHARED
> under mmap_sem, then if needed grab reference to struct file from vma and
> clear suid after unlocking mmap_sem.
>
> I haven't seen previous iterations, probably this approach has known flaws.

mmap_sem is still needed in mprotect (to find and hold the vma), so
it's not possible. I'd love to be proven wrong, but I didn't see a
way.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security

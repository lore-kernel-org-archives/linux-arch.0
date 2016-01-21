Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:33753 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbcAUXlp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jan 2016 18:41:45 -0500
Received: by mail-io0-f179.google.com with SMTP id q21so71665478iod.0
        for <linux-arch@vger.kernel.org>; Thu, 21 Jan 2016 15:41:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160121232238.GA4616@pc.thejh.net>
References: <20160111225750.GA4256@www.outflux.net>
	<20160121232238.GA4616@pc.thejh.net>
Date: Thu, 21 Jan 2016 15:41:43 -0800
Message-ID: <CAGXu5jKFyCy=-=GvNJXw_uZeVZfcXRAXPcPZq-OqtORPtW97tA@mail.gmail.com>
Subject: Re: [PATCH v7] fs: clear file privilege bits when mmap writing
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jann Horn <jann@thejh.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@amacapital.net>, Jan Kara <jack@suse.cz>, yalin wang <yalin.wang2010@gmail.com>, Willy Tarreau <w@1wt.eu>, Konstantin Khlebnikov <koct9i@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20160121234143.xfIllpxO4BGKrqT9swUhTKTjpiIXHyH4Qa6cMFHdpzo@z>

On Thu, Jan 21, 2016 at 3:22 PM, Jann Horn <jann@thejh.net> wrote:
> On Mon, Jan 11, 2016 at 02:57:50PM -0800, Kees Cook wrote:
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
>>
>> Instead, detect the need to clear the bits during the page fault, and
>> actually remove the bits during final fput. Since the file was open for
>> writing, it wouldn't have been possible to execute it yet (ETXTBSY).
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
> [...]
>> diff --git a/fs/file_table.c b/fs/file_table.c
>> index ad17e05ebf95..ca11b86613cf 100644
>> --- a/fs/file_table.c
>> +++ b/fs/file_table.c
>> @@ -191,6 +191,21 @@ static void __fput(struct file *file)
>>
>>       might_sleep();
>>
>> +     /*
>> +      * XXX: This is a delayed removal of privs (we've already been
>> +      * written to), since we must avoid mmap_sem. But a race shouldn't
>> +      * be possible since when open for writing, execve() will fail
>> +      * with ETXTBSY (via deny_write_access()). A remaining problem
>> +      * is that since we've already been written to, we must ignore the
>> +      * return value of file_remove_privs(), since we can't reject the
>> +      * writes of the past.
>> +      */
>> +     if (unlikely(file->f_flags & O_REMOVEPRIV)) {
>> +             mutex_lock(&inode->i_mutex);
>> +             file_remove_privs(file);
>> +             mutex_unlock(&inode->i_mutex);
>> +     }
>> +
>
> If there is any other setuid file I can run, can't I just do this?
>
> pid_t child = fork();
> if (child == 0) {
>   /* fd will be 3 or so */
>   int fd = open("setuid-file-with-bad-privs", O_WRONLY);
>   char *ptr = mmap(..., fd, 0);
>   memcpy(ptr, my_evil_code, sizeof(my_evil_code));
>   /* su --bad-option just prints usage and exits, without touching
>    * the fd - but since su has the last reference to the fd, __fput
>    * will run with its privileges */
>   execlp("su", "su", "--bad-option", NULL);
> }
> int status;
> wait(&status);
> execlp("setuid-file-with-bad-privs", "setuid-file-with-bad-privs", NULL);
>
> I think that file_remove_privs() really needs to be changed to use f_cred
> instead of current_cred(). That would also fix the known bypass where
> you pass the fd to a setuid process as fd 1, causing the setuid process
> to write more-or-less controlled data to a chosen offset, or similar
> stuff (see
> http://www.halfdog.net/Security/2015/SetgidDirectoryPrivilegeEscalation/).
>
> Or was there already another patch that does this that I didn't see?

Andy brought it up as an issue, but I view it as a separate problem.
Both things need to be fixed. :)

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security

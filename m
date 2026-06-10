Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9529C328
	for <linux-arch@vger.kernel.org>; Wed, 10 Jun 2026 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132363; cv=pass; b=aMWfglLCdK5pKlo3SZ7PHyuZgT91T6duNBKrdYP+Mua29Y+l6i89mVWCvRYk0TvzX9y64POx6QMgjwBdGKpwKSQ69iA1d9k3J/qv+bz6CbY2wnd4oR+BFufjAnqwfZwCshNUrXgcNfNdVTxguSvYhMG6DSO0Ew3boFDApQbm2AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132363; c=relaxed/simple;
	bh=oEzIwJCTEGfUPAMEdjx97uQ6KkcVMIzM//6ziaFjsoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqtJW4ZyOZ+KVtoIilTwHHbPw+FMRoS9SYdIdOlN2+80am3jZ9B5/50YdwKeqKYJShmGptY3YelfVU8Q0nXi6vYrj4j1nTnEu1uSHDEoanjAmoHRgjOnYjk2iqGlRMKVYe3QHaQBykM7xl9i/79qdlRbYHTQud0hksONBLQk07w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qEn4tIWy; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEn4tIWy"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68d23430690so14581957a12.3
        for <linux-arch@vger.kernel.org>; Wed, 10 Jun 2026 15:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781132360; cv=none;
        d=google.com; s=arc-20240605;
        b=DlcC8/SKqKKGLn3TWV+yoQC88utTBvtki0MNOfw8Mo5D2qH+NXmsHMPeKl5Ksg6NHY
         erlk0QlEytONbYO8ATkZ51cmHgcGIPiY6pVcdypd3l+KvubaNkxQsyXLYwA+/QmDKBaM
         EGbTM3L6Cr+V1y+QkrASgnga0AiGjF0zqqaD2ZyCNmT6LfE2d7APzVE0gZTXbWxFksAu
         aqgudCA7volEXsC7nMomlyGnmV+JtWY4QDSbK9UQ3Pi5RPKmANGyEPFX4WjTDD2ZxUM2
         eko/EhDXacQ3F2TKf5ZaOgQlQXysaZTqy/juI13YWPzccg+2E7svK2RlDxserqDGVRkg
         NqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oEzIwJCTEGfUPAMEdjx97uQ6KkcVMIzM//6ziaFjsoE=;
        fh=lTMH9NXvrlp7PZZZIL13tT+wTA48a58kq2wrcT9FW9Q=;
        b=TnnJrhOqLLb/6iRUWi4b3aNzIp4LbnHy00wE9U4JcDbj5LA4h/VIjj1lcAUP/Ob292
         KJH/HIzmwrl6uCvwW9N82TRZiT29Wvc14mt4SG3sMj5jI68UpsnJqW9Bz4ZOdRKFnXDz
         tfVlTZcy3UBDShgUpaF89rU7VOV+Ieb9LyPkBu1UIpjgVxdpaC1xQn8d78+J4RbuOvPK
         rGdbkQ74N4lJ03FCqjKSuy+oEwAO3FaCDYwGABhOGUa0oo8+pOtSwN8o9uY3FB9EjhaS
         t20pTFqgORDeNDic+KEI6G5xJVbGJcT6ATRahXWQ7Ta2OIO+VdEkMoIoX73oBW9cK3nN
         pM7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781132360; x=1781737160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEzIwJCTEGfUPAMEdjx97uQ6KkcVMIzM//6ziaFjsoE=;
        b=qEn4tIWyzGrvjUgvO574u6bAFB8n1Bu79d+gI2oyFcZSTG2PxL2qFkS7fainrrfrV8
         JBMIOmi08eKO7E1Aj9XPkaMb/2J2V2mSI7ole22hdtrek8TO+kg6IQXol5thJJGLcXMe
         TvO4cEC9g7XMzDu8Gbw6Hh4RTK6UDyqZgmnbe9NiDrFgl0sQHcsJgFHeiKnJjdk481Pa
         w4sUsM1k/OBPwW1b8N0SWLEtBrHQN5WlmEpsaRUJglIosxsDBsE1YWDA5Rex2p+aGKkL
         kFPkBD5MrcWH4toiaQBJb1V1kvARUTSG8MKzUg5hBPmu5IGHxgP6iZ423hIxmHohe/Ax
         vulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781132360; x=1781737160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oEzIwJCTEGfUPAMEdjx97uQ6KkcVMIzM//6ziaFjsoE=;
        b=C2HugWi8mNIJJjUs4FenatMIUY1fXl3hTLaM5MwOaSBY18JvbwKHlSTPmBNZDuj7b/
         Om389t9tPAWBhiFHbow70Ig2yLH6ddMvZyCBcQ9J7lWBGSQVjxos7thUSm0zQIYtnMTI
         rCw/JFdzostOx5WPCFbylFYA0GiFInRBxjwzHSXESGbd98LdzeRH7tUtyULTsNu91Aou
         pAbQ4uLJTPsgQEb/lU6QpDUVgnyS70SlyHtlnLViN+h7mjE90s+86VuTfiG3Ihpat7yf
         7Es+ZdS0CpqB+ikolNpTpEgpldVDxoTmp+SAzEQZImQtXsF98pM6p8RCFHI0EpAH72rQ
         YdhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+D9fIi2MuvF4sUA7/ILg3udufEcyO17tEdj3ki5RwLkP3kBrZqzBkL0TcgH1yHufdAA8rPQyR8Cm15@vger.kernel.org
X-Gm-Message-State: AOJu0YyVcT8IHYwDJ7vN2+/JanCaA99InmKDc5Xspu1WJP+gahM4vTTf
	/RY3zmYFgH7OAxjvk4GxlvzDo5FzHdnQNDw6QjZ4NVa7LPSJYbiw0jCUHdfDoYj04rnSf3HdPuL
	D/L4ng9yhoz5QzGohbJHpyfgTdJCmlf8=
X-Gm-Gg: Acq92OFB/XddbWJXVrZL+7PaDR4gM0XBjCpmuUi+HsAjltooMrE5k61IAfoBygVBDj0
	bCwHQzPTghaMSe+6H9QUW8rXjDzIL4leWh7YZris2mNUTwO4OxBaTh5cG0u/NNfL+2/F2goim70
	4EqfCfHBHTRy/kZdBmXF9eEaIJm5Zm0D1MfR7uQmXk5Vp01qezC5V6xBGdnP5LvZEC5qdl12m8d
	ByFj8Gebi+vmaRM5OzMFxjDJBJyq+4bX0AqJFUC067pdaxsWkx6aHBUQ7njgbP+KSChKiDsPcen
	TlAM8dLNQsyBdg6oKLFT0IotNaqUtFYSckAPWjjJn0DrxGQknQ==
X-Received: by 2002:a17:906:6a1c:b0:bf1:ac1d:94b0 with SMTP id
 a640c23a62f3a-bf373eec601mr1347239866b.35.1781132359944; Wed, 10 Jun 2026
 15:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528095235.2491226-1-me@linux.beauty> <vealb52tv5suireenkke4lul2l3wbnaul2rp3ea545ly5wa5ty@yk3aksvp7skt>
 <CAG48ez38OEE8ZPLyU6nr9=cYx-hMsdoh5WRrv-GMZGMDKyyOTA@mail.gmail.com>
In-Reply-To: <CAG48ez38OEE8ZPLyU6nr9=cYx-hMsdoh5WRrv-GMZGMDKyyOTA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 11 Jun 2026 00:59:08 +0200
X-Gm-Features: AVVi8CdthNiQaFys6OtVKdO_jwR53Q5mhKecw8_q9iDf4OCUN-Dc5Jgmeo3bc0c
Message-ID: <CAGudoHHq-AKfWwRXuVbmz0B3PPK=Z7gW=HeUYOe_8k4fvPJFHA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Li Chen <me@linux.beauty>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 5:02=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Thu, May 28, 2026 at 2:55=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> > This problem is dear to my heart and I have been pondering it on and of=
f
> > for some time now. The entire fork + exec idiom is terrible and needs t=
o
> > be retired.
>
> It seems to me like vfork+exec is a decent UAPI building block, on
> which you can build nice-looking userspace APIs, though I agree that
> this is not an ideal direct interface for application code.
>
> > Additionally there is a known problem where transiently copied file
> > descriptors on fork + exec cause a headache in multithreaded programs
> > doing something like this in parallel. I only did cursory reading, it
> > seems your patchset keeps the same problem in place.
>
> I think we almost have UAPI that would let you avoid this issue?
> You can use clone() with CLONE_FILES, then unshare the FD table with
> close_range(3, UINT_MAX, CLOSE_RANGE_UNSHARE). That is not currently
> implemented to be atomic with stuff that happens on other threads, but
> if we changed that, and it doesn't provide a good way to carry some
> FDs across, but it feels to me like this could be fixed with a variant
> of close_range() that removes O_CLOEXEC FDs except ones listed in an
> array.

Suppose you want to exec a binary with the following fd set:
0 is /dev/null
1 is fd 1023 in your process
2 is fd 1023 in your process

You have tons of other fds and you don't want any of them anywhere near thi=
s.

Clean interface from my standpoint would avoid any unnecessary
overhead and would allow you to clearly specify what do you want.

In this case whatever the interface it should provide the ability to
map 1023 to 1 and 2 in the child. With the current syscall set you get
refs taken on these on clone, then you have to manually dup2 these
which is separate syscalls with extra atomics on top. A fast & elegant
solution would allow you to tell the kernel directly where to install
the 2 files.

Also note in practical terms userspace likes to closefrom/close_range
anyway to get rid of unwanted fds which happen to not have the cloexec
bit which is yet another syscall to invoke on the way to exec. A
better interface would instantly avoid the problem by not copying the
unwanted fds if not asked. For viability for use as foundation to
build posix_spawn over it such copying would have to be supported of
course.

>
> > There are numerous impactful ways to speed up execs both in terms of
> > single-threaded cost and their multicore scalability, most of which
> > would be immediately usable by all programs without an opt-in. imo thes=
e
> > needs to be exhausted before something like a "template" can be
> > considered.
>
> (I think probably a large part of this would be stuff that happens in
> userspace, like dynamic linking.)

I have not investigated userspace, even putting specific APIs aside
the kernel has *a lot* of avoidable overhead.

>
> > Per the above, the primary win would stem from *NOT* messing with mm.
>
> As you write below, I think we have that with CLONE_MM? The C function
> vfork() is kind of a terrible API because of its returns-twice
> behavior, but I think if process cloning with CLONE_VM|CLONE_VFORK was
> wrapped by libc in a way similar to clone() (with the child executing
> a separate handler function), or if it was used in the implementation
> of some higher-level process-spawning API, it would be a perfectly
> fine API?
>
> Or am I misunderstanding what you mean by "messing with mm"?
>

I was not aware of this functionality, let's assume it indeed works.
You still have the file issue described above.

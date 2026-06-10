Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456138E8A5
	for <linux-arch@vger.kernel.org>; Wed, 10 Jun 2026 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781134867; cv=none; b=r55bw1e17Apzi9Gt3gA2991pB1vP7u8CoPxawLS4EkW3SEO4aj6hqSsgYVtEKaSDKvlJy+o1UVSn83WfGN/kIXg+MqQleXvi0j0pqaN0AOe52EaTnm7HxPbLgzos2j5JlQor1/ZTC1rhhnLUbEQQTJSn3e+8TQ/qV3w4g5qxkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781134867; c=relaxed/simple;
	bh=WLKFSvoHBAuURbkH0azFPoXH0iTJec2iRBnKyq7YHT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg6Se7EvGH7d4u0BdfaOOkzuPZP10IRBxOmGU45CYn8lWvtjm1lBA1F97aPw9nNK4jizFtKhdKfL/IYEhQJEjtaKNagHTdXNunIaqFi1hF2pjYeHwvMBeSFa2BO3g1JzsHIsDhb2756LlvYL0zk0cPGKnGBUJLJeBwrCKhJHiy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slxb3N4b; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slxb3N4b"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so3425155e9.1
        for <linux-arch@vger.kernel.org>; Wed, 10 Jun 2026 16:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781134863; x=1781739663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hItbBwzE/UemJbPm5Fn7DOlYpjoWK0GBfBYmIwvZBe8=;
        b=slxb3N4bFW1Qs3memInulsiDuICRh2Zf9ZsFSF1rVQ6FbolbwDG06y5HMYqDQ+mfpH
         Q3a9n74hereuyEvM9iVcgruLRnEeLYlPWIqVTVTkbFQ83+4U1mr2LyFN2OisN60VIRIu
         VM06mzir7DHgGFkA1iRFyBHcrQPA3uBO4eajSfqiPHW/4rHOAioxIjoY1GJYYpI3LIGx
         7FJFGIL25t2kEN0M90zrhuPf0rbhPVcfcH8Zb4DMekwwgReCijPDrG+wpiTPk2P4G9A5
         28Py06VePTd2y10Rzca9UJfwv+h/fcBSHPRqr/cr1XhGgvGW3dfrV2xLYomD/lFwAyxl
         wnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781134863; x=1781739663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hItbBwzE/UemJbPm5Fn7DOlYpjoWK0GBfBYmIwvZBe8=;
        b=LTXmO9WLudGGLDS7foqCa47//92vuGI/mqKFNmlFBCGC/AuaMmXfuQXwVMhmgVKfZB
         a5boP7A0HJpTJG5ZJaPWjeL2tnPX1Ah13k+JsivUCDAwbwS7bltsj/sN4HTLOq5FzINs
         Hzh2wxdnDz4rPu5EY71cqc7KIuFWljg1+nbZ3Llo0TG8hbZ0qPZTBkUJPJKIpc5kY00M
         fe8FX0tdj1xBGejZwV4m0mbqCkI3HPO59GaAvx1OxZioeaek6QKKwF+cgCUy17KbtGtc
         rJFhH9b0Bc9W1ztMXBEOtXz1hnoH5h3Eg53tCoU3Nsm7TGD2JX3M7gEdI66U9BvU9PjR
         Fltg==
X-Forwarded-Encrypted: i=1; AFNElJ/roq1joEwEzEFD07tfLEWAlshKnXaCB7sguv/OzQElM4yMXrFT+EhqGCRaxL24Xf2eJsrPxpkTKEY8@vger.kernel.org
X-Gm-Message-State: AOJu0YxsrpreafeTly+rbeu6kBSXXKsQm/CjQ+wxmMgV0qxN28YKOdz+
	E5xsmZUeaHY4VQYTETalwcX/T0S1xGiU0Q+sl7KtSXhtLxpG+lnFPYJW
X-Gm-Gg: Acq92OECHFAnsIyNquoySPszdcNakisJHht7lWOh15ry5PuNNALLrZFxVHtfK0R7sQV
	Z5BrbsVRjUISV77l4XiYd/MMaAkAKIC898GtU47FvTOkg/EbE5c5mZG710vtAe6Lb+7awUi8XUV
	qKqlNebXRgwS04kFZ6zZOuUWfAaoloIZDEbbErbcv9rk5d3nsq+Qc6/Zh/5ys3jamAv0ED4lso0
	KGnCMvbcmU4jrfPzMLkJZRiTZDtK2+NxhnFpkSUQT5041BeKck2fwGxivhgHw5yIWN86aqx/pR9
	ORuhaAdb/e3EX3SsL9GrKjzwMHR4X5mCieu2EHtc1JWNGWzZ5ghsUkwN0t8GywAWtDjoz8g7rzy
	7wJOJhdGpdo6+ggd9hvYCleF01qfakCejqBKuEL1uf8bix9NFOwtv4F7Lv99mxikx4iE1ONNWrk
	87qlQU2RuZG0oXDAowuT1TOzbGLxf2cGHVmW/hiyNGbGUa/qtcgd7ydusEwIAAKVuW/of8ILgYA
	d6X6u8u5Q==
X-Received: by 2002:a05:600c:1554:b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-490e5318363mr872135e9.15.1781134863322;
        Wed, 10 Jun 2026 16:41:03 -0700 (PDT)
Received: from f (cst-prg-85-110.cust.vodafone.cz. [46.135.85.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e422e321sm4497435e9.0.2026.06.10.16.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:41:02 -0700 (PDT)
Date: Thu, 11 Jun 2026 01:40:56 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Li Chen <me@linux.beauty>
Cc: John Ericson <mail@johnericson.me>, Andy Lutomirski <luto@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	linux-arch <linux-arch@vger.kernel.org>, linux-doc <linux-doc@vger.kernel.org>, 
	linux-kselftest <linux-kselftest@vger.kernel.org>, x86 <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
Message-ID: <hd3i6pxxohsjesyid7nhuic6ppp6nyoxxpwa4mny6riqvpyqec@mylfprni2yaw>
References: <20260528095235.2491226-1-me@linux.beauty>
 <20260528-madig-fachrichtung-fehlinformation-61117ba640da@brauner>
 <CALCETrWJQpLR4n1cpichBk8=uExSKLWTMGU3BufGdk_WE_p5UA@mail.gmail.com>
 <19eacd64508.26b92c022125848.262962729296162879@linux.beauty>
 <4e049396-377d-48a7-a34c-91318413a876@app.fastmail.com>
 <19eb181fdd4.6d028f442844776.3737831021032223216@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19eb181fdd4.6d028f442844776.3737831021032223216@linux.beauty>

On Wed, Jun 10, 2026 at 08:29:06PM +0800, Li Chen wrote:
>  ---- On Wed, 10 Jun 2026 01:27:47 +0800  John Ericson <mail@johnericson.me> wrote --- 
>  > Hope the above answers your question? I suppose my ideas lean more on the
>  > "future" than "empty" side --- there is indeed a thread in the thread group,
>  > with real VM/namespace/file descriptor etc. state. Moreover, state gets
>  > initialized before the process is started, so the actual start is a pretty
>  > lightweight step of just letting the scheduler know the now-ready process can
>  > be scheduled. The only thing that distinguishes the embryonic process from a
>  > real one is simply that it isn't running --- i.e. isn't (yet) available to be
>  > scheduled --- so the pidfds holders are free to poke at its state.
>  > 
> 
> Thanks, this helped a lot. I looked at FreeBSD/OpenBSD/XNU after your
> note. FreeBSD has P_INEXEC, OpenBSD has PS_INEXEC, and XNU seems even
> closer with P_LINTRANSIT, described as "process in exec or in creation".
> Linux does not seem to have a single equivalent today: current->in_execve
> is only an LSM hint, while the real synchronization is spread across
> exec_update_lock, cred_guard_mutex, and the exec path.
> 
> I am switching my local WIP from the two-fd builder model to one fd,
> closer to Christian's sketch:
> 
> fd = pidfd_open(0, PIDFD_EMPTY);
> pidfd_config(fd, ...);
> pidfd_spawn_run(fd, ...);
> 
> In my current local version, I still use copy_process(), so the fd points
> at a real task_struct/pid that is not woken until run. Following
> Christian's point that existing APIs can handle this not-yet-running case
> with ESRCH, I currently make ordinary pidfd operations that need a real
> started process return -ESRCH before start.
> 
> I am not sure yet whether Linux should grow a general exec/creation
> transition state like that, or whether a narrower future-process
> lifecycle is enough for this API. I will think more about that when
> working on the pristine process version.
> 

As I tried to explain in my previous e-mail this approach does not cut
it because of NUMA.

Suppose you have a machine with 2 nodes. The parent-to-be is running
on node 0 and the child is intended to exec something on node 1.

When the parent-to-be allocates and populates stuff, it takes place with
memory backed by node 0. If you allocate task_struct, the file table and
other frequently used (and modified!) objs in this way, you are
guaranteeing performance loss due to interconnect traffic to access it.

Trying to add plumbing so that all allocations respect numa placement is
probably too cumbersome.

The primary example for that is looking up the binary to exec in the
first place.

userspace likes to pass paths which don't exist, meaning checking for
the binary before any hard work is a useful optimizaiton. Suppose the
binary to be executed is in a container bound with a taskset using
node 1 and the content of the fs part of the container is currently
fully uncached.

When you perform the lookup on node 0, you are populating a bunch of
metadata (inode, dentry) using memory from that domain. But the intended
user will only execute on node 1, again resulting in a performance loss.

In order to not do it you would need to convince VFS to allocate memory
elsewhere.

So I stand by my previous claim that ultimately a pristine child has to
be created (like in this patch), but which also has to do the work on
its own.

Suppose there is no explicit placement requested anywhere. Even in that
case there are legitimate workloads which will eventually be forced to
exec stuff on another node. Even these have a better chance retaining
full locality if the child process does all the work.

Per my previous message I don't see a clean interface to do it.
something quasi-posix_spawn is probably the least bad way out, it will
also allow userspace to easily wrap the new thing with posix_spawn
itself.

Also note there is another issue with the fd-based approach: the fd will
get inherited on fork and will hang out in the child afterwards unless
explicitly closed. Suppose you have a multithreaded program which likes
to both fork(+no exec) and fork+exec. With the fd-based approach you
have no means of stopping another thread from grabbing your state thanks
to unix defaulting to copying everything. There was an attempt to fix
this aspect with O_CLOFORK, but this got rejected.

Whatever exactly happens, NUMA is a sad fact of computing and needs to
be accounted for. The approach as proposed not only does not do it, but
it actively hinders such deployments.

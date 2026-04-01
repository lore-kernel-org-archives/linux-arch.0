Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219D43659E4
	for <linux-arch@vger.kernel.org>; Wed,  1 Apr 2026 04:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775017199; cv=none; b=No4sp+V0du2NLXJExGnjjb6OtYB9DzXN86lE2ZI4g3f9KrTBqwJk0lHqLsNAJ8AdPVAPVU6hRwnMj01Cklt2J6ila4b9lWMqK6+l3zOTj8991bEfgxcoMKmAMFrgBcr1ACbq0LVb8sRLAnjpBq/r6TXX1aIZ/7Tn9nA6sS42INs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775017199; c=relaxed/simple;
	bh=GW93UXZZL/AJcKizbF9MiVumq3K474SVj7RsNaKwVOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvixUcRVMm42DQHjM0eVor+lg64D1aPd6EEuAsqJHKO2dpuJ99JopJzP9TXkHtE69suIrZSR6gUFAIitgmV3yGmadnAuf33ZpkfSoCU5PZnQ+HxlSgBYkci4lRBEcSjFMwcEO2WdUUrCK2Zp3Go4+Rjwp/WQwJtt67RcbscvcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoAsePdW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoAsePdW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so53288515e9.0
        for <linux-arch@vger.kernel.org>; Tue, 31 Mar 2026 21:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775017195; x=1775621995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FpxTHYW9PCEMGlcpR0vGWm0MEHjo8lB3T6MyF9di0eg=;
        b=SoAsePdWP+Ziu75muCsKjEsNT5foNHSfACGEKlH+KoatdtogWSGBjns4ClD/iv4mJt
         Ri3qw7tPE90PLba3ryuu4fY+h1eQFTRZUhq6wVZopWnamtXCXY6ehGhl5fxtIu2R+0JD
         Ed1GhIHmbKmeBVHjtNqhv9+Jy7nluoh9gRQe0vHgmf/Xs+c91QYDTLI2bG58VEyyp67k
         vHG0GmkP/UA0TJFx0xmDqPLIuKKwg5DE+5gR0QUop0Ywgs8XzWcEXy01CrNF9hW3TH6I
         SmNNdxw1ImY+Y598Oc1pxiLHnTMZsEt1bKCenZRGU2GjSCFIJ4YhSJM2huqsHZbGNfIY
         NOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775017195; x=1775621995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpxTHYW9PCEMGlcpR0vGWm0MEHjo8lB3T6MyF9di0eg=;
        b=E/+oVIf1mpPEbOwOJLG4Gmi/byjEbSbvmxtk5ghssjLBCnLf+uVvTulZL5V5A03DOs
         jU94GTrdxfp6uYjOkmtM6I23MxbH/Ux5As1Onu5xPoVNe8R9eOLjgI8E50anWkx6dOtq
         slPoyWWxCmErkvoKhf9Oqx1gNAtX1sVU+C7DreEWSMaWUqBWsdU0GgcDWqxBXwduwg2h
         5sPUNEURdMKBIqoFParwajaDGBLqPsAqTyt/gX7CXfwT6nfIE5lLbYtTSGqDZcAkkh3B
         +fdt8AXaMgbJrDs6lr8WSY7Lnc+IyXqh9ly/Zhhc3eVwmVTRjd+PD7KBsM5SHwJYhknZ
         Wwew==
X-Forwarded-Encrypted: i=1; AJvYcCVwtHWNuTfxh9e3xrtORCwbG0+eGzr0cY1ou9oPfZ25HprJYsb1fsvx10IEFnah685IFTXC/iMlh4gZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxGZZpUpwD5ozbLtrn1EseT1KM2eeYPpu6CJnh4xeXQSSv220TM
	LTmVakRg9mYb76UKUdfK1k7+W8/dDSLAi3AJNwZL1OGDrUoYtLZQUzfv
X-Gm-Gg: ATEYQzxpM5Mw5qkQoqW7vpDjrEek8JUiUoeUrOjUcK0HCrJ7woGA3LbSbkQOfbvNiD3
	PXVg+/h0/5qFUSnXZlGlCzuhKFt4ofxooPxyANv/We4AqZpGgI2O6oNzvPFUm1ygeoAUWWdqjBt
	ZCkkuG7hKijI9vWXeBXREwMSWYPw3RKFLdaCOo3GGHGlkMwmtbrM7IdW4KomHY7MOQVQfn9lFT8
	7t1fPYhdYXN5BezWEjZYWc67p1P1Kqt9fqD94/KRXyEnRAVCvOqUmKzCd1gS5wjN7S2cWgQ1SkF
	mtuBAvqZZMNjZLkJhm3qqak8n9I9avrhz96rhFKgHlHGs1P5w5Pb94E9RAOlPcyTyoxXyq8cCKV
	IBkFEs8L0eqyixeG3Rw6gZPkrDppo1R1rIuGitOAzy4Q5YfbDBHxZ3whrW4BdG64FzFgzcAzTf+
	YokNZMMlr7/xwKwHEYLflRjul9ak4fEx0ms1ojy/QlDHrXkMkqbbNzWTYa+t189O+EoE8YvVI=
X-Received: by 2002:a05:600c:c178:b0:486:f8e9:add5 with SMTP id 5b1f17b1804b1-48883591777mr30069195e9.19.1775017195266;
        Tue, 31 Mar 2026 21:19:55 -0700 (PDT)
Received: from f (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e7e9728sm87601455e9.1.2026.03.31.21.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 21:19:54 -0700 (PDT)
Date: Wed, 1 Apr 2026 06:19:40 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Alexander Aring <alex.aring@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Andrey Albershteyn <aalbersh@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, cmirabil@redhat.com, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
Message-ID: <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
 <20260331172011.3512876-2-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331172011.3512876-2-jkoolstra@xs4all.nl>

On Tue, Mar 31, 2026 at 07:19:58PM +0200, Jori Koolstra wrote:
> @@ -5286,7 +5290,25 @@ int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
>  		lookup_flags |= LOOKUP_REVAL;
>  		goto retry;
>  	}
> +
> +	if (!error && (flags & MKDIRAT_FD_NEED_FD)) {
> +		struct path new_path = { .mnt = path.mnt, .dentry = dentry };
> +		error = FD_ADD(0, dentry_open(&new_path, O_DIRECTORY, current_cred()));
> +	}
> +	end_creating_path(&path, dentry);
>  	return error;


You can't do it like this. Should it turn out no fd can be allocated,
the entire thing is going to error out while keeping the newly created
directory behind. You need to allocate the fd first, then do the hard
work, and only then fd_install and or free the fd. The FD_ADD machinery
can probably still be used provided proper wrapping of the real new
mkdir.

It should be perfectly feasible to de facto wrap existing mkdir
functionality by this syscall.

On top of that similarly to what other people mentioned the new syscall
will definitely want to support O_CLOEXEC and probably other flags down
the line.

Trying to handle this in open() is a no-go. openat2 is rather
problematic.

I tend to agree mkdirat_fd is not a good name for the syscall either,
but I don't have a suggestion I'm happy with. I think least bad name
would follow the existing stuff and be mkdirat2 or similar.

The routine would have to start with validating the passed O_ flags, for
now only allowing O_CLOEXEC and EINVAL-ing otherwise.

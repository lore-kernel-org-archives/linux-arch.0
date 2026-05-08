Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BC333B6D5;
	Fri,  8 May 2026 23:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778284324; cv=none; b=Idyz7lPoYIM1YCWk49OaQBAZPk0IapBjH8Fx+m9UMFfoZkLmQ/finq8z1BZUcApKKMIArwqzKU5SS3Gwu0A8CYH6Bttqrc4s4rm4H7t8rcMLNh4OH+HqyqSq2rAvxGoP8YUFoiBLxQZ0HNKl417eiUN5zhJuoLYHmOQ8TW6id0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778284324; c=relaxed/simple;
	bh=sRGeCV6w/1XLJmMiis3Zh7jmQgcOwgTRye0mEg75f10=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JEiJNdjHA8d+Dr71aqgY3722NKU8a9BuONe8qofG3W6Bko37012qD4vpUnBnY8lSYBq/T3CMHBk1OA6eUsfxoNM9pPMOMDtLCPeERN/6+MUi4QTfGJxo3YNEhUB9lhVGLJW62+BPA6WZIfJ95eMNjeltKu48ByOOl1H0X71QZyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ALxe9ym2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ALxe9ym2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3FDC2BCB0;
	Fri,  8 May 2026 23:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778284324;
	bh=sRGeCV6w/1XLJmMiis3Zh7jmQgcOwgTRye0mEg75f10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ALxe9ym2sHgz7eBUYTEuUFF41oSDC4cz3mXGbV78Dfm+oqqwoIPEWCG2MGsWVZ8Z4
	 +kLExX711p4ifWyTbJVe/8ddxhSROJmkV+x4IqyVtlJY9/t7d0pJNbyrMmNlQj8ehW
	 q/cmtclmZMfOII99C0Y3VrNtwUEN0IxC3cncAWjE=
Date: Fri, 8 May 2026 16:52:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, Rae Moar
 <raemoar63@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org,
 workflows@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-doc@vger.kernel.org, peterz@infradead.org, Alessandro Carminati
 <acarmina@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Kees Cook
 <kees@kernel.org>, Linux Kernel Functional Testing <lkft@linaro.org>,
 =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Dan Carpenter
 <error27@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v9 0/4] kunit: Add support for suppressing warning
 backtraces
Message-Id: <20260508165203.1cd1b27e664754d18dbea899@linux-foundation.org>
In-Reply-To: <20260508-kunit_add_support-v9-0-99df7aa880f6@redhat.com>
References: <20260508-kunit_add_support-v9-0-99df7aa880f6@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 May 2026 17:02:44 +0200 Albert Esteve <aesteve@redhat.com> wrote:

> Some unit tests intentionally trigger warning backtraces by passing bad
> parameters to kernel API functions. Such unit tests typically check the
> return value from such calls, not the existence of the warning backtrace.
> 
> ...
> 
> Solve the problem by providing a means to suppress warning backtraces
> originating from the current kthread while executing test code.
> Since each KUnit test runs in its own kthread, this effectively scopes
> suppression to the test that enabled it, without requiring any
> architecture-specific code.

Thanks.  AI review has a bunch of questions:
	https://sashiko.dev/#/patchset/20260508-kunit_add_support-v9-0-99df7aa880f6@redhat.com

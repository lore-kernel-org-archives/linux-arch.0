Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0E414DDB;
	Wed, 23 Sep 2026 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790204022; cv=none; b=LH+Y4xcmW+y2Yw0bpVln596s3+WuPJe20pvPjRRZ5aaf6NByRcMvsa+axMApsc1sahI/tCM5sm36p22dwCX5fItbAdK6N9/Tb1sCVbPQGmk+gj+yF2K2wnZ8vDrU/gTwHTsUZoTfLn6Si7lHmUecHYCP+peLKZpb9XoZ7m+Vbyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790204022; c=relaxed/simple;
	bh=fwZSaqpmByB20i96UeW2mqdIG75USPYigGVMnEnWY2g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OzSZqg27PtUb7A3AptNI8YPe+kHIl+BjSCt3uN2/1v8nQivHoLCQXYpMxJf7JvSxm5y2BI/a2PMlELB7I6TeSwVQD+/5q8PLZ0DJrR1iWgXbNyXaHFuZeYNM0tXTWLqGUFoSMOwRw5ykBfGgHpjlDue3S+P9Ayv6TY8GCpwa/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=scGfOW6F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="scGfOW6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D461F000FF;
	Wed, 23 Sep 2026 22:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790204021;
	bh=ep7wns9wPyTqnmGHhjmbGEV+muuH/iLwEmgevdLFK+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=scGfOW6FNrNiqxjD54xQajwaC+4WYqC6RG/88f1T+E4tqhorzFVBYXL1q9XvKZq/L
	 EBTL5TAFO+L4muscbIneqi/sYK9xm73Aa56lde4wfrllpbydBzL/wWnM9xNyKrubd9
	 sbmpz652ub/EEGRm8Lp6Vjcgd5QxMI1CtuS4ssq4=
Date: Wed, 23 Sep 2026 15:53:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Arnd Bergmann
 <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Jonathan
 Corbet <corbet@net.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel
 Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-pm@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>,
 Philipp Hahn <phahn-oss@avm.de>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v11 00/38] dyndbg: Fix classmaps API for subsystems,
 query extensions, selftests
Message-Id: <20260923155339.bdc677e8e688611bcf190ad9@linux-foundation.org>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 16:34:24 -0600 Jim Cromie <jim.cromie@gmail.com> wrote:

> The drm subsystem has *lots* of debug statements, in 11 categories:
> 
>  $> git grep '\w*_dbg' drivers/gpu/drm/ | wc
>    5663   30159  542864

Methinks this regexp was overly promiscuous, but point taken.

>  $> git grep 'DRM_DEBUG\w*' drivers/gpu/drm/ | wc
>    2206   12834  202332
> 
> All of these are bit-tests on __drm_debug, exposed to users as
> /sys/module/drm/parameters/debug. Many of these are done often;
> vblank is done ~100/sec for some displays. Over the uptime of many
> boxes, this is a lot of cpu cycles on bits that are almost always off.

A __test_bit (or |) every 10ms sounds quite negligible?

Especially if __drm_debug is __read_mostly.  Which it isn't, afaict. 
Um, low-hanging fruit?

> Dynamic-debug excels at replacing such tests with NOOPs (via static
> keys). Classmaps was devised to bring that 0-off-cost to drm's
> categories.
> 
> Classmaps-v1 went into the kernel in Sept 2022, in 2 chunks:
>   b7b4eebdba7b..6ea3bf466ac6    # core dyndbg changes
>   0406faf25fb1..ee7d633f2dfb    # drm adoption
> 
> Sadly DRM-CI found a regression during init with drm.debug=<initval>;
> the static-keys underneath the drm-dbgs in drm.ko got enabled, but
> those in drivers & helpers did not.
> 
> So in Feb 2023, it got pulled:
> commit bb2ff6c27bc9 ("drm: Disable dynamic debug as broken")
> 
> Root Problem:
> 
> DECLARE_DYNDBG_CLASSMAP defined the classmap, but its repeated use in
> both core and drivers violated a K&R rule "define once, refer
> afterwards". This flaw resulted in a regression; with drm.debug=0xFF
> boot arg, drm-core got enabled, but drivers/helpers did not.
> 
> This patchset replaces DECLARE_DYNDBG_CLASSMAP with:
> - DYNAMIC_DEBUG_CLASSMAP_DEFINE (invoked once in the exporting module)
> - DYNAMIC_DEBUG_CLASSMAP_USE (invoked repeatedly in drivers & helpers)
> 
> _DEFINE exports the classmap it creates (in drm.ko), and other modules
> _USE the classmap. The _USE adds a record referencing the _DEFINEd (&
> exported) classmap in a 2nd __dyndbg_class_users section.
> 
> At modprobe, dyndbg scans the new section after __dyndbg_class_maps,
> follows the linkage to the _DEFINEr module, finds the (optional)
> kernel-param controlling the classmap, examines its drm.debug=<initval>,
> and applies it to the module being initialized.
> 
> To recapitulate the multi-module problem wo DRM involvement, we add:
> 
> - tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh:
>   Alters pr_debugs in builtins and test modules,
>   checks results against checksums of expected results
> 
> - lib/test_dynamic_debug.c & test_dynamic_debug_submod.c:
>   Builds parent & _submod modules with _DEFINE and _USE inside #if/#else
>   blocks, reproducing the 2-module scenario under selftests.

So what I'm understanding is that this series presently has no effect
upon DRM?

What subsystems *does* it affect?

Sashiko had quite a bit to say.  It hasn't quite completed at present.
	https://sashiko.dev/#/patchset/20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285817;
	b=NFtIlm96aX9OQTxgj+43DONljsUUAzRbxBTcsaLefEHhDjFe8bO2s5a1AykcYDZA28LM
	 LTycnCWPLcenmTViKkBazJM6HdWbDBKwyVU6c039ZctTbq0j/ToQBAQQXAl8pHEq2NV+x
	 n1yyIAu7B6OGCnJGuNzNxPNGYMQOMIkqgN8bHTV250bDkT+MZIcjrzsCiGySRftEXzcKP
	 tFFIyAAr8JVkvPJ/qmIbtoTZvJc7/mDIPxUqIvOW/CI2eTfin8BG9W2eOHeDg4YKSVfFj
	 Yf2aDjSu4w0jGBcHMCqY06LG/8Dmjqoy4rJ6FTCRKAI69RlyT29zTZaY3beIp+kGu8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=PiLUJIzj7M85elEEaNM0ojSu5Qbzbb6E3aVU0YwZNoU=;
	b=0SCoC7H1crYkr4IWyJFRbGFJ/GCRmfP+0J28Hp8ZO90v4+05aonCdSYPV8jYVwHn93ir
	 ykFOVO38bQSdwnn54XrChJw/phcVk23LYPBCALQTm983hr23vQIQXnEwK1vq++JZBydih
	 NcXL9TfQjh+41W89Aq1t+KSZmHOFzigs6TZWHyIEF87IQP2kIP5Lg3JA2wW8eLFm9zFVI
	 zQWX/a9AKuAVFLuinvXVyLsk7DJ2aDU6P7ocg4niTiQM+YXLUQXw1/LLH1i6clrjgoKZj
	 rFamQxjJdJEB3q58VG8Y64O3ouq2yaluPsnobcyMKAcFY11b7FgMqWg69J/62oc5MTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VBBtzV54;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1531B606A31C
	for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 14:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1531B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VBBtzV54
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso1434780f8f.0
        for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793285814; x=1793890614; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PiLUJIzj7M85elEEaNM0ojSu5Qbzbb6E3aVU0YwZNoU=;
        b=VBBtzV543IUjp3L3nroXQrlC/QE6S+8gXo6jr4I0eHzp4Q3/fgQ96if7xtxcQ+VqLz
         s19qARniM3o+7h8g7xtxQPTJw/6p358LWMNXRgqkJIbnJXHxlMrWB7nJPDaF+NKET7mJ
         0JgVER0btUhOoW8vZ34IN5qvDsQpFvfF6CMOLDdw4Cr5yB+LzHLeARk1o3ukGjmCmDUt
         kXFNpVftEBMuvndsJvgf76u6usMMe1SZa9+N1Z3DTuOK6veiNZBgg/utXmh9//asLtiU
         DoqQFHQyI8iPg6OBshBXAjQR+NUPAsqfXG2eCbmRTIiNmqjpPisFlRbuRJxjKj3j8X9p
         322Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285814; x=1793890614;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PiLUJIzj7M85elEEaNM0ojSu5Qbzbb6E3aVU0YwZNoU=;
        b=aKy0JREvnCrBTDNRsZUzxmVd9u3RnsSAgT0PhlPiHthVANykTn8IcGc05ocXWBSfPK
         421JETXzKc/9aZxqiauhSHbOJ+IhvqT6OgIs6e5RlhoQlwPW1mQitHdZOqgECDP3Jz01
         oD4CNRGv2QAIwVvCl7mbnl2dtSC8iZjCZzuyIYfUTluQkI/j8k6Z7h8odhswRy46hOVz
         M4YUrkgG83ozby1zIavkQd3ChF5zBnjmaApzGkuMMaunIRFbKPrFNI1yz9roRW6GgpbA
         MrbUHAu3ou3QoiuW2KcOMLomjBZQOjydj9K36kwFT2pOb8QNEmqmFKxlq7Azy17toU1S
         Chwg==
X-Forwarded-Encrypted: i=1; AKwUvBwXQXJkV3g7tWR61fYCvjSo+tcSkTYZ78ili88/VOUgLUzZ96wq+WRuZT4neu0xjo79RhCeNuuh0nUh@vger.kernel.org
X-Gm-Message-State: AFq9FYJahXl3vfZrYvNTx/iKoYOxjpZS6UdhNl+ds+bayislZgosvAaU
	LVvVrBa2FnxrCJGjFnKdxCwXpTvagftXeG+wLSAaZxv4iMcVj4hYcPQ+9Tk82Pj3I1s=
X-Gm-Gg: AYBFou3tuCAOcb6oseCY6UYDVSJ3PuMR3wII/8s4FnYotzEYDjVXMXUC7TJcfwTxQ3e
	aIP1deBsCy7Dd/cYov/RnQtr6Xw5NknxMYr1h+BivytFyKVfC//giIy334XZOt8Sj271YoT8Nyx
	x5anmJ9fQwEIJE/hYNy6iSiZiQrwIxMAxTEyldCR9R3PkSSSI1zACTC/dnYAk6Qd7RV2/wSWz7p
	2/nBi2p4eWugRHNmEx02VVXATosRk2XkQU6V8A8doc/EQv6wCPqQRX4hvWvFJZbBX6TZupmdlMm
	GRJBV7bB6CsVSfGNBcd5G3JKMj40s0vIw6NlNm2T/BzyKmYxssPANrAZj/IRx0ad7mJVC7b13UY
	86SmFSRR7pBYpaRR4ucPGZH32Yj8FAh+eVcqdHqR4i8Vl5tX4MU84rvsnGCZcJEhDUlGKPH58z/
	Cfpc27rfL4cBHxXbn39pJ+1Ee7GknIh9fybIrHtqddoM4Hx95yiSEypZ4o6C57zWMEtAwCZzMGh
	QDVlfxv8xQmc61f7vQNsDazBZIKdcQignh6ybMxZy3AKxbIXPWqsxJ6WHnK1hm9nfKMtrFAYKqG
	g7yxjEBbq/CzKuwgPop0IWCXYYjOo3DOe5Y=
X-Received: by 2002:a05:6000:290d:b0:48e:6a23:4a09 with SMTP id ffacd0b85a97d-48e6a234a62mr3002384f8f.54.1793285814407;
        Thu, 29 Oct 2026 07:56:54 -0700 (PDT)
Received: from pathway (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39b3sm35816798f8f.10.2026.10.29.07.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:56:53 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:56:51 +0100
From: Petr Mladek <pmladek@suse.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: jim.cromie@gmail.com, Jason Baron <jbaron@akamai.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jonathan Corbet <corbet@net.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org,
	Philipp Hahn <phahn-oss@avm.de>
Subject: Re: [PATCH v12 33/40] dyndbg: Ignore additional arguments from pr_fmt
Message-ID: <auNes2b11NqUey3C@pathway>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-33-3c8cc5725def@gmail.com>
 <as4W9hToBqAvbzJ-@pathway.suse.cz>
 <20261027132253.5f3a461d@pumpkin>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261027132253.5f3a461d@pumpkin>

On Tue 2026-10-27 13:22:53, David Laight wrote:
> On Tue, 13 Oct 2026 13:33:10 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > On Mon 2026-10-12 20:37:04, Jim Cromie via B4 Relay wrote:
> > > From: Philipp Hahn <phahn-oss@avm.de>
> > > 
> > > pr_fmt can be used to add a common prefix to any output from a module:
> > > 	#define pr_fmt(fmt) KBUILD_MODNAME ".%s " fmt, __func__
> > > 
> > > But adding additional arguments breaks dynamic debug:  
> > > > error: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" passed 4 arguments, but takes just 3
> > > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > > |                                                  ^
> > > > note: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" defined here
> > > > | #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> > > > |
> > > > error: ‘DEFINE_DYNAMIC_DEBUG_METADATA_CLS’ undeclared (first use in this function)
> > > > |         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
> > > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
> > 
> > I wonder what this error about undeclared macro means.
> > 
> > > > note: in expansion of macro ‘DEFINE_DYNAMIC_DEBUG_METADATA’
> > > > |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));         \
> > > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > note: in expansion of macro ‘pr_debug_ratelimited’
> > > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > > |         ^~~~~~~~~~~~~~~~~~~~  
> > > 
> > > Add an additional ', ...' to DEFINE_DYNAMIC_DEBUG_METADATA_CLS to slurp
> > > any additional argument, which `pr_fmt` might add.
> > > 
> > > --- a/include/linux/dynamic_debug.h
> > > +++ b/include/linux/dynamic_debug.h
> > > @@ -351,7 +351,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
> > >  		dump_stack();					\
> > >  }
> > >  
> > > -#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
> > > +#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
> > >  	static struct _ddebug  __aligned(8)			\
> > >  	__section("__dyndbg_descs") name = {			\
> > >  		.modname = KBUILD_MODNAME,			\
> > > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > > index f594c1266bfd..5d701952e739 100644
> > > --- a/include/linux/printk.h
> > > +++ b/include/linux/printk.h
> > > @@ -742,7 +742,7 @@ do {									\
> > >  	static DEFINE_RATELIMIT_STATE(_rs,				\
> > >  				      DEFAULT_RATELIMIT_INTERVAL,	\
> > >  				      DEFAULT_RATELIMIT_BURST);		\
> > > -	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));		\
> > > +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\  
> > 
> > IMHO, this changes the existing behavior. The prefix added by
> > pr_fmt() will no longer be stored in DEFINE_DYNAMIC_DEBUG_METADATA().
> > Is this intentional, please?
> > 
> > Anyway, if we do not longer pass pr_fmt(fmt) then we should not
> > need to add "..." into DEFINE_DYNAMIC_DEBUG_METADATA_CLS().
> > 
> > By other words, we newly pass just the format "fmt" without the parametes.
> > The 4th parameter was added by pr_fmt().
> > 
> > 
> > IMHO, the right solution is to keep pr_fmt(fmt) here and extend both
> > BEFINE_DYNAMIC_DEBUG_METADATA() and
> > DEFINE_DYNAMIC_DEBUG_METADATA_CLS()
> > to accept var args. I would expect something like:
> > 
> > #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
> > ...
> > 
> > #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)		\
> > 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt, ##__VA_ARGS__)
> > 
> > 
> > or maybe, we could "eat" the extra parameters in
> > DEFINE_DYNAMIC_DEBUG_METADATA. It would mean to keep
> > DEFINE_DYNAMIC_DEBUG_METADATA_CLS() as is and just add the "..." into
> > DEFINE_DYNAMIC_DEBUG_METADATA(), aka
> > 
> > #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)		\
> > 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
> > 
> > 
> > Or do I miss something, please?
> 
> Don't think that will work.
> Won't you end up with ".%s" fmt as the string without the extra argument.
> So you need to keep the expansion of pr_fmt() together until is is finally
> substituted into a printf-like call.
> It is possible to enclose it in () so it is passed as one parameter and
> remove them on the final expansion.

My understanding was that the format is stored in the metadata as is.
I mean that the string is not formatted in this code path. So that
the parameter values are or can be ignored. We just need to make
the compiler happy.

But I might miss something.

Best Regards,
Petr

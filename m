Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80C3CF68E
	for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2026 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036390; cv=none; b=e93vtWggoP4dD1cKcE4dLjd77Lib6nio1DT4R9EmbIWf+LeYYQmu2IrGJMjD7gKsccE1hL5ake0l+Mv2zelAw/YuzVWvd+78S6DdZ/6CcNrp0Mlb3O0gv0p6VDiwh5R0Hkq8Yvj/I7h0Emddo5x8h7qpj3t7QrXYC6H2JxG9qTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036390; c=relaxed/simple;
	bh=JLYUPRgY3VU17t6D/KBuFz5KGU4hmck2Zh29/I5+qBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STTqyZgF5kcgJ6GqaidFn5E6AYJPo/D+KfzTki3dvP7IzXy/u3qaSGkBFR6xDRA1uQ/tn5KC7NFSDoXWGqUk91TdUA4pimkK5KMhihTtXDr+YGuacBurS6gSPMX2ePtvQLt7sYYlGzLPD+Cd+LlLtP2TQrUBgN/eWRS3TeLgP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ea/X5/ww; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea/X5/ww"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49cf4f81d86so53446765e9.2
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2026 03:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789036382; x=1789641182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mRawg4Z5mHetwl9Q1bHnfv9ACubJE6CgvdpEZZ5c2ZM=;
        b=ea/X5/ww5FaU4VhPEnXhYVwwwm6cRfrZOBsy9YrO2dBe0VdGku1hFm0QZ/cUUXJFIn
         2cXqaN/93kIR541V4hjAfpqo2Hmc+B/VzlXqBV9y/j+bw2RSSfp5zUVzjJhWBkoB/hgk
         PEYGK36CidTRPDZZB8kzGZuDCdKxQVbP/b+buyxFLTQrVPTWDmeX4ngi8j7qohQ7NUGV
         9aseNcbGv22MMu5meU9j6u7UrLjadmZ8UH9KrxkRLEigLxgGciWEstEmrwCtXkp1IELt
         TSImCsnfm/dLwc2KtCfQ126rJkqX/sHDf2twwsHlieVeQuIpsdcmsUgKbi6MNYWbF7l5
         Unrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789036382; x=1789641182;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mRawg4Z5mHetwl9Q1bHnfv9ACubJE6CgvdpEZZ5c2ZM=;
        b=TE0jNRKOCeKNqcihj6FED+plVvzLzor8/69ajYHW9v4z4uaciye54X99AE2+aWamZq
         PZS0NN3v6wJ7uedVx1yGR64URcgh9PNwJj6p5qlXOCn/xQh2anouvztjdQuq81ia9f5z
         gZ/qBDcPiMptjTIwxlazcxiEUgBTJVh680Zob1nMrDQd8tOlAiOK4fVzLlG/Pb7EsV5i
         E4ztmSXI7I2rVIkNSDKMMYsN6plH1IuyFEnooeSRqzIbFyUlmv5ZLbRo3zKVDbaC2hKW
         CxdGW2fqB6ER2dVZA1U3WKJeKRmm0Fe5chXcONcK0fZkcUjNeCh4W3fXB8qj4SLwMuoV
         4mTg==
X-Forwarded-Encrypted: i=1; AKwUvBwta3Iz6jZtgV6d+qYzZx38Nb+VC86R4gKkdmKh9HXI2mhq1oGeXOHIJ3x1buKXIbOmV4x59IdqtmVD@vger.kernel.org
X-Gm-Message-State: AFuF++lOc3bIiXHTAJEWd3AvtGjbxBMZWbZNviu04IpNeEz8eh4rigdh
	ULhCwpk5hKANNl4rh7i8s2aA9xHYMytuwEM4wxMNZNhTB/cDrFSST+Gf
X-Gm-Gg: AYBFou0pq42PbX8cHrPUSS5Gp36f+vqop3a/ay1Ylj5PpNw94V2u5p4NGrNbJdHNwT/
	O4WXg3lfVehRjDrf6KWAS5FCaJ6RmErI8D/GlQ7vhi1cECRlucgxqeGZnM2rTjXcEbKn8smO/ni
	me1HdA8R2mdybnczIfJhXodOWjH9Rtt2ZQ7Hm9XmjgRohTX4Yf9MDHxZlc99Sc35eepGrm9TSal
	Ugs+CcybmYuoIAziLvG7W8GLHQ5Mx343RsOA42VmdAD4nIAydsQWUbSpZO+DqH0c2ZWAeZ+zMGp
	Nz9pdsVKGCyN+ktSo+1r0GtiiylF13wP3az8I1qPMlwW1Ovv4bMk+3JcgRQkM0sAgHSvzND4EZF
	MQR3/ha897SbDw0mNqZ/xYhZd+e+MrfXGRzWlxAGPECVnmLDKXurQylx1nrCswvf1zb1lAejyLS
	CtXpmkCwoKjauuQujpQi+3xbU1WE1310UGw6wqujkIFHAovSIbt7yjbY4bJbhv343xZCzW4bGu1
	wA79W6ZvyaUVrNVcRvoCqlBHu01QePUGGGH
X-Received: by 2002:a05:600c:4f43:b0:49c:fc6c:be0b with SMTP id 5b1f17b1804b1-49cffd457a4mr308628235e9.17.1789036382123;
        Thu, 10 Sep 2026 03:33:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26bfd04fsm60049095e9.10.2026.09.10.03.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 03:33:01 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:32:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Alexey
 Gladkov <legion@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Jonathan Corbet
 <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 17/23] modpost: perform srcversion hashing in parallel
Message-ID: <20260910113259.743b9686@pumpkin>
In-Reply-To: <20260908-build-speedup-v1-17-5dc1ac01672d@kernel.org>
References: <20260908-build-speedup-v1-0-5dc1ac01672d@kernel.org>
	<20260908-build-speedup-v1-17-5dc1ac01672d@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Sep 2026 21:55:17 +0100
"Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> modpost does a lot of single-threaded work hashing files from each object's
> .cmd file.
> 
> This makes the build slower than it needs to be, so do this work in
> parallel.
> 
> This is egregious for allmodconfig builds - for instance x86-64 can end up
> opening 200,000 files individually and hashing them all serially.
> 
> Parallelise this operation by maintaining a thread pool for the hashing
> work.
> 
> Combined with the per-file hashing commit this cuts modpost's run time
> nearly in half for an allmodconfig build.
> 
> Module.symvers and every *.mod.S are byte for byte the same.
> 
> modpost is on the serial tail of every allmodconfig build, however
> defconfig does not set CONFIG_MODULE_SRCVERSION_ALL and is unchanged.
> 
> Whole build, 128-thread Threadripper 9980X, best of N runs:
> 
>                                          before   after     delta
>                                          -------------------------------
>   x86 allmodconfig, touch mm/vma.c, gcc    33.4s    30.2s     -3.2s (-10%)
>   x86 allmodconfig, touch mm/vma.c, clang  31.1s    28.1s     -3.0s (-10%)
> 
> Assisted-by: LLM
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  scripts/mod/Makefile     |  1 +
>  scripts/mod/modpost.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++++--
>  scripts/mod/modpost.h    |  2 ++
>  scripts/mod/sumversion.c |  3 +-
>  4 files changed, 74 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
> index fbd5099e0441..fdd486184f9c 100644
> --- a/scripts/mod/Makefile
> +++ b/scripts/mod/Makefile
> @@ -5,6 +5,7 @@ hostprogs-always-y	+= modpost mk_elfconfig
>  always-y		+= empty.o
>  
>  modpost-objs	:= modpost.o file2alias.o sumversion.o symsearch.o
> +HOSTLDLIBS_modpost := -lpthread
>  
>  devicetable-offsets-file := devicetable-offsets.h
>  
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 550ccd753ed8..882169e51851 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -16,6 +16,7 @@
>  #include <fnmatch.h>
>  #include <stdio.h>
>  #include <ctype.h>
> +#include <pthread.h>
>  #include <string.h>
>  #include <limits.h>
>  #include <stdbool.h>
> @@ -1717,8 +1718,7 @@ static void read_symbols(const char *modname)
>  	if (!mod->is_vmlinux) {
>  		version = get_modinfo(&info, "version");
>  		if (version || all_versions)
> -			get_src_version(mod->name, mod->srcversion,
> -					sizeof(mod->srcversion) - 1);
> +			mod->need_srcversion = true;
>  	}
>  
>  	parse_elf_finish(&info);
> @@ -1736,6 +1736,72 @@ static void read_symbols(const char *modname)
>  	}
>  }
>  
> +static struct module **srcversion_mods;
> +static unsigned int nr_srcversion_mods, next_srcversion_mod;
> +
> +static bool get_next_src_version(void)
> +{
> +	struct module *mod;
> +	unsigned int idx;
> +
> +	idx = __sync_fetch_and_add(&next_srcversion_mod, 1);

When I've done this is the past, adding 'a few' items was faster
because it reduced the contention on the counter.
(Although there were probably some very cheap 'actions'.)

> +	if (idx >= nr_srcversion_mods)
> +		return false;
> +	mod = srcversion_mods[idx];
> +
> +	get_src_version(mod->name, mod->srcversion,
> +			sizeof(mod->srcversion) - 1);
> +	return true;
> +}
> +
> +static void *srcversion_worker(void *arg)
> +{
> +	while (get_next_src_version())
> +		;

I don't think the extra function call helps.

> +
> +	return NULL;
> +}
> +
> +static void hash_srcversions(void)
> +{
> +	unsigned int i = 0;
> +	struct module *mod;
> +	pthread_t *threads;
> +	long nr_threads;
> +
> +	list_for_each_entry(mod, &modules, list)
> +		if (mod->need_srcversion)
> +			nr_srcversion_mods++;
> +
> +	if (!nr_srcversion_mods)
> +		return;
> +
> +	srcversion_mods = xmalloc(nr_srcversion_mods * sizeof(*srcversion_mods));
> +
> +	list_for_each_entry(mod, &modules, list)
> +		if (mod->need_srcversion)
> +			srcversion_mods[i++] = mod;
> +
> +	nr_threads = sysconf(_SC_NPROCESSORS_ONLN);

One thread per cpu is probably a few to many.
It might be worth adding a command line parameter for the 'max threads'.
Possibly with -n meaning 'all but n'.

> +	nr_threads = nr_threads < 1 ? 1 : nr_threads; /* On error assume 1. */
> +	if (nr_threads > nr_srcversion_mods)
> +		nr_threads = nr_srcversion_mods;
> +
> +	sumversion_init();
> +	threads = xmalloc(nr_threads * sizeof(*threads));
> +	for (i = 0; i < nr_threads; i++) {
> +		if (pthread_create(&threads[i], NULL, srcversion_worker, NULL)) {
> +			perror("pthread_create");
> +			exit(1);
> +		}
> +	}

The main code can call srcversion_worker() here.

David

> +	for (i = 0; i < nr_threads; i++)
> +		pthread_join(threads[i], NULL);
> +
> +	free(threads);
> +	free(srcversion_mods);
> +}
> +
>  static void read_symbols_from_files(const char *filename)
>  {
>  	FILE *in = stdin;
> @@ -2729,6 +2795,8 @@ int main(int argc, char **argv)
>  	if (files_source)
>  		read_symbols_from_files(files_source);
>  
> +	hash_srcversions();
> +
>  	list_for_each_entry(mod, &modules, list) {
>  		keep_no_trim_symbols(mod);
>  
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index d5f6d82837d5..10d5f8f2f293 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -127,6 +127,7 @@ struct module {
>  	bool has_init;
>  	bool has_cleanup;
>  	char	     srcversion[25];
> +	bool need_srcversion;
>  	// Missing namespace dependencies
>  	struct list_head missing_namespaces;
>  	// Actual imported namespaces
> @@ -213,6 +214,7 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
>  			Elf_Sym *sym, const char *symname);
>  
>  /* sumversion.c */
> +void sumversion_init(void);
>  void get_src_version(const char *modname, char sum[], unsigned sumlen);
>  
>  /* from modpost.c */
> diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
> index 5501d6aa0bea..4521b92ef868 100644
> --- a/scripts/mod/sumversion.c
> +++ b/scripts/mod/sumversion.c
> @@ -249,7 +249,7 @@ static int parse_comment(const char *file, unsigned long len)
>  /* FIXME: Handle .s files differently (eg. # starts comments) --RR */
>  static bool stop_char[256];
>  
> -static void sumversion_init(void)
> +void sumversion_init(void)
>  {
>  	static bool done;
>  	int chr;
> @@ -402,7 +402,6 @@ static int parse_source_files(const char *objfile, struct md4_ctx *md)
>  				     line, strerror(errno));
>  				goto out_file;
>  			}
> -
>  		}
>  
>  	}
> 


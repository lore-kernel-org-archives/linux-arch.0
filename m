Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682CF3168E8
	for <linux-arch@vger.kernel.org>; Thu, 29 Jan 2026 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697709; cv=none; b=oAfUzSsTl7yIcMN3duwxN7K/dxk4V88KessJoXp/hfhMSfpEV1TYpgiCu33JTbmYiTt/fvTudFuQNOMWxbMuSZ3M4EhKXGvs7cX1jCsZ8Vgn8fWO4wHzNymL8Ie6pVA8bGPY3Ynm/bi5Lyfc2eamSjqwo5YHUDU0oHN798sHuOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697709; c=relaxed/simple;
	bh=F0b8hnfWHbsOvhccuNKow2wnsDEWWek2mfssz8GMxsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLrS96cdAz2Jnx3JuLVVJ1kv2tykVa17383i42FABykbMvv9UuWdIEfaex4NVdmNbRHXFoadwZxhyeyAoeh/oiwTcYc9o3U8McRAoTwYHqnNxY5DwWYiz6v3QGac9UMzZehquCRLjoI61GTIqwRuFNKf3H7br0qDC7DUNLM2e/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DCdmfDvY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DCdmfDvY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4805ef35864so8625045e9.0
        for <linux-arch@vger.kernel.org>; Thu, 29 Jan 2026 06:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769697706; x=1770302506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiXqWFBbTqasdWh8G25vCefiMtu7P/aKonwdz1Q+QEk=;
        b=DCdmfDvYjNE7C1O2jiZtSAx5VFyXp7kD/Q7BI5euaOR+Aece3eGzUKs2VWuSK81cFV
         1GFRfcCRI5Gukv0bp9TizXNuyZfwsTpyqy5P+VkNyNxkRnws1AEIYl2hhEUd8UPa0/PW
         y+3TgGZgtrKtkyDwNhatNcP1EY9CAYjT70lD1b7Fs8UyFAO/WOJh+HnBMwFvQxOZlZBz
         QuNuFBwZImsqcYQ1MDZ/A8alCPRdprBiX4rjuvwJ24bIc5V0PHY1wJV1+QrbSDS7TFwP
         0REI1tXsfsQnH7ryQMfgAhS9va5/2Ax1ONsbMHGzdnpe132FZc+P1kz/N4aylIk7XgMh
         TwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769697706; x=1770302506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RiXqWFBbTqasdWh8G25vCefiMtu7P/aKonwdz1Q+QEk=;
        b=HWV30q3S0/aqXlQkNbZWqvE1+Qxfi+eZoVMEv8Jm7cHJdJxWJvd8IMce1JWvQ9YxUd
         VpBlQ5COV3FyruxXLnham5EgX1/xF9plYGRDLigz/UshlCRLlqAv8GSWBrJ9M3ULL7kq
         7JVQdMg31KhQK/KqXKWxVb/EnIq6ck5Hx8ID0O/jpDoh3L53m1MWYPC3BU0KvTYoBeod
         ueGKVOrAw2IlF2a9mtKJ8RCcjy74nbrP915KxBsqG9DA4URbKu5APSIzEPsHfPRDSRVd
         bfzlpmA5UJGgbAuIw5dbyQ/u6AAkUaJF5y34kq1JnSD6bVNZ1XStnerxTai9eI6XUxHV
         z1aA==
X-Forwarded-Encrypted: i=1; AJvYcCV4yN6cscyn8sWQ1rImmoSMtIing/doQhXTt2o+nbY8h28g1KoQrY1JU6G2YAzeur2Jzt6Q0ddX3LaI@vger.kernel.org
X-Gm-Message-State: AOJu0YwOpF85C5qnik1A7IreCD2lme5UnYXwvIktu0hdaJ9RM7+g7Org
	HR7A3o8KRB4tYhHX6BcLnDB/xhUa8qePc3Ner2Bl4/1Yj2idDyYvOPj93kMe4vXWN3s=
X-Gm-Gg: AZuq6aIK+/1knlZEoDswERau7mr6fHsLI36vCGETJFiRto7morf2N60R9PeolOR6geX
	io6cSTOlwo7dkRI/Z6dxmphb9K72Rwf9ev23EeYI6gCR10UH4ZYEU9LnCxLFik2N0WhClowGjhq
	/TH1NZTAD7u8JhTIhBxNYhZU5OzE+xVCcPpjm+ZEQwiXQcrwNVwMdgBcyUUH1vIG/LLw/dPdfkQ
	wwu+LpcSIS+9TYX0w5OdWiq8bPGag0U1LrGrk7n+bmdpH8vvnvpdoSPoq2xZYLVk5blbhZw1HA1
	ANpnUIkkMEPTYHtc71O2l/CV98FvdwJ8U+Dq3mi5lzUt9o/n+pZCnLAOAnBIbnmGIE6m5xUfKek
	13lVirTcRC2Q0XDTYzUomEAIiREEbUt6e2MoO5OqJ61YYs2GhuN0Dt4XBcUfe3AR1kS1GaN3pe6
	+0tg9Nd4OHbFidCRCytK+/rpWNnNXv/A==
X-Received: by 2002:a05:600c:8b76:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-48069c49d54mr120114805e9.24.1769697705735;
        Thu, 29 Jan 2026 06:41:45 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37433sm182396725e9.10.2026.01.29.06.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 06:41:45 -0800 (PST)
Message-ID: <aa92ce4a-d336-4d03-b87d-1c39b1c553da@suse.com>
Date: Thu, 29 Jan 2026 15:41:43 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/17] module: Move signature splitting up
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez
 <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicolas Schier <nsc@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>,
 =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-12-0b932db9b56b@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260113-module-hashes-v4-12-0b932db9b56b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> The signature splitting will also be used by CONFIG_MODULE_HASHES.
> 
> Move it up the callchain, so the result can be reused.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> [...]
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c09b25c0166a..d65bc300a78c 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3346,10 +3346,21 @@ static int early_mod_check(struct load_info *info, int flags)
>  
>  static int module_integrity_check(struct load_info *info, int flags)
>  {
> +	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
> +				       MODULE_INIT_IGNORE_VERMAGIC);
> +	size_t sig_len;
> +	const u8 *sig;
>  	int err = 0;
>  
> +	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
> +		err = mod_split_sig(info->hdr, &info->len, mangled_module,
> +				    &sig_len, &sig, "module");
> +		if (err)
> +			return err;
> +	}
> +
>  	if (IS_ENABLED(CONFIG_MODULE_SIG))
> -		err = module_sig_check(info, flags);
> +		err = module_sig_check(info, sig, sig_len);
>  
>  	if (err)
>  		return err;

I suggest moving the IS_ENABLED(CONFIG_MODULE_SIG) block under the
new IS_ENABLED(CONFIG_MODULE_SIG_POLICY) section. I realize that
CONFIG_MODULE_SIG implies CONFIG_MODULE_SIG_POLICY, but I believe this
change makes it more apparent that this it the case. Otherwise, one
might for example wonder if sig_len in the module_sig_check() call can
be undefined.

	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
		err = mod_split_sig(info->hdr, &info->len, mangled_module,
				    &sig_len, &sig, "module");
		if (err)
			return err;

		if (IS_ENABLED(CONFIG_MODULE_SIG))
			err = module_sig_check(info, sig, sig_len);
	}

-- 
Thanks,
Petr

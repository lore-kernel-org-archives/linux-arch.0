Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFE137B018
	for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560721; cv=pass; b=naRBFowKZzKyInebyJx0on4ZCM+Bh+QyY4hRiiG2ikB7QsSM2dy7rVB48azyhyrpjftMT7pjn4TtuIxbo0dQcLoFr2JzNGF+lA+IrJdn6JxEM2Pctin0YIIGYlolCo+Jq3Vt8PPkUO/4ZAVi7lOPzjQ03xAG4tUTTrtbPNW6W2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560721; c=relaxed/simple;
	bh=TZyAuJdbm5lNyLHWtj8JZifMocqSIEE/M15yyD9cWUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+AuFGPjPglPUZ44Y71365haJQAFSFs7iFkc9gpsMFB7JoLr9Hee8HpRIKOwyOuJGxYEBvwc2bCUioVGDION9jcNCE3oSgLWqVaqDaNhBY4BKbmT2hfag5Vdh7Jx7JEz+E+s4wuZ85Yms8xmaeEYv1O64+/u/s8+tihlNeNNNTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eM9IcxQM; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eM9IcxQM"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79853c0f5b9so16255667b3.0
        for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 14:32:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774560719; cv=none;
        d=google.com; s=arc-20240605;
        b=EdRyNBSgM3Cgl6lUBqn85J6MQEipQ6iy0vRM0oy+SOiRaQ6SJAsSMSyfJupaS+xax+
         hwo8dBRBWHfUUHQBFxmFWkDcGSP3OAU8xFz62RWr8nsixOObUMKQd5Hq6RXFZN1tmi8G
         YjtqGRHMnqCEbS40onEPaugZ5+CDqGmMWS/LmmnlTTUzO8yEbqrQwP66bu2tfp9FYBrZ
         rgrqPuiJieMdGSPDQKLNfTHJSRfSpPZGDsA1wqm58HGOOh+qgZLr7w/ONMSQFe8Ppmb0
         yIPkoTTno39X1q+kdQMzwGvbs8C3BhJC6iOHMmDHZlD1SdZLnjukqhhfvmBwK09HJLX4
         tcAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TZyAuJdbm5lNyLHWtj8JZifMocqSIEE/M15yyD9cWUw=;
        fh=6GQym18l9PYWFVKQyoXeMAqXqK5sDNbLR4BoEVY8cD4=;
        b=jFlgkTtCpZY1hOJFiSNPSyDRp6Rmh5ms0QEqp9rtF6euUhzLDeR7rPaBnTONHqv16w
         o5WYHUom9564HDsxcOvqliIWUaVoRNGs2m9A6xl05g6T4EDEGiwdKrSU0TLAuyqSfQak
         zoD4j3mHrYfuchZB7BlSQVrGRKUr8zg+sSqdwf/f+q+/mtQ9NHZOFNg3ErD3gKVZXt9E
         Y/fGpgdzl9Roj/2uOHWJM0WcevGd0rlnY6VdPps2/sMgjheixZyovwNJWe5umHuH8SRP
         DlcpaEn6Qyoti4XG7AyLn5i6eugzNOOLwpOndCLcIUjSG07ghnQCqglhiEIMZ/Ef5av5
         P/zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774560719; x=1775165519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZyAuJdbm5lNyLHWtj8JZifMocqSIEE/M15yyD9cWUw=;
        b=eM9IcxQMdkh5g5nrznPx/7bNHh6gu2pNvEL9P/9NVaMKCuCourNIlY/DLKGcARZKF0
         2q9xQEBScAghF0Lh4QMhu++9lQUnOiYnqZrCeFmEE/mLdVNGrOTdcs1V7U2nUhdHeIw/
         kd0g1QS15XrgyewFmrfMvqsCgOIFOLckPQ4HoZlFlsw9MAFnH7eDoGM9bLf4he8lU+No
         nhIWSpOjnGTMsrQDr+0898hIig01STIXHXA/QiYyteK9BIKbAed1Pf+Cp4+gh5hANUUT
         DahhlCz321PacBAK1rub8pBmfFAxwm8N99azmjKv7ecDMeIDaS1UfM86Q1QDSoa7IUze
         McUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774560719; x=1775165519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZyAuJdbm5lNyLHWtj8JZifMocqSIEE/M15yyD9cWUw=;
        b=XKo2So1DkbWmVPfIbNdrbg9HW8ar73g+CI6J2aHka6MyUmWs2B3bbmEDC4HvFWqUrg
         GMJ8ekQr3SpKD6yrASVC+muT759QM+C/+JbOv+8CsVgm5YYD2yfAB+aVVzH/WvfcKHfu
         MoVl/KXd5iv/Fb4F1ni/SVWjaJSna+je3Y4SVow4KJKlPmYnsI+hG3wKd2+0waz9e2xC
         jbTCg7uTdDIjGWhPjXiXbwwV+swLpSrur24HwTCmkadrLs+dzG+ZZXglvn0jTqtRc3xh
         uIZ8CSiQM/QO1LZ2TiS+kgTtdtz3Rx5Kvi0cmhTQWl1rKswgcO28vkr647hmqrLwIWv1
         WqxA==
X-Forwarded-Encrypted: i=1; AJvYcCUuCIwArQnAzLg6rfmJbuCJZvU6wRayzh+qByu58R8o6MUSmlApInr8L9jcV097RnVnYHZqAuJSG57t@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/eHM/7URM0F3r71sU7+WOZgs0CnGhefjhwhrbXpKqQcUA7LZ3
	0IeXX4Q43hHeoFdMf12kJgE0p2mEE0R0xk5HUoHSU2ZJ77/MhzX5sFaLpWSOSaFtKQsZXUgyf7t
	XtwWuJxwC+mFHG8pAe/6goT7sMeo4pKtNH+jrxCOn
X-Gm-Gg: ATEYQzxgUtg5LDgj7l/TSn0VNOPO+3nr9/htlcjBD+QsIqV57U6YO1UI9ITjFVkRP8l
	cJspvkI5+8lHIXmzFSy8k+pDLdPbi+eTW0WRtKNIdGb5q1/CXYIFiH/K3wWneRjvWdZ0b2MBa4o
	M3+umLRZu5SCVJjBaozPNTsfVvcrOOzJSIYGoUMuv8HtXb8GFA1T0obNRpkFbUkJQDF+OG5mh7T
	6XebZEsPu7taY83rR811Q4GsSqipcQ2XzDzyUNmFjDND2V05Srk5dHA1jdROWNGYIRAHQoTeJY0
	CLj58MFL
X-Received: by 2002:a05:690c:368f:b0:79a:b409:b62c with SMTP id
 00721157ae682-79acf39ca9fmr101703267b3.22.1774560719217; Thu, 26 Mar 2026
 14:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-kflagstab-v4-0-6a76bf8b83c7@google.com> <b83c9524-13df-47dd-a597-bebab93288d8@suse.com>
In-Reply-To: <b83c9524-13df-47dd-a597-bebab93288d8@suse.com>
From: Sid Nayyar <sidnayyar@google.com>
Date: Thu, 26 Mar 2026 21:31:45 +0000
X-Gm-Features: AQROBzDfMgZ3xEPPX-07HtZ6qMri8pHd4_VLlgIvmfka8IMZId9kQN4ffSRsYhc
Message-ID: <CA+OvW8butx7OD5ArjWXm7osCf4tV2O-suNHcHj4gFaQfMMPjwQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] scalable symbol flags with __kflagstab
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, maennich@google.com, gprocida@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 12:49=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> w=
rote:
>
> On 3/5/26 5:55 PM, Siddharth Nayyar wrote:
> > This patch series implements a mechanism for scalable exported symbol
> > flags using a separate section called __kflagstab. The series introduce=
s
> > __kflagstab support, removes *_gpl sections in favor of a GPL flag,
> > simplifies symbol resolution during module loading.
>
> I noticed that the series has a bisecting issue. The module loader
> doesn't see any GPL-only exports after patch #4. I think you'll need to
> squash patches #4 and #5 to fix this. Alternatively, the patches could
> be swapped, with the caveat that GPL-only symbols would lose their GPL
> property for one commit.
>
> Nit: Please use simply the "module" prefix in commit subjects:
>
> #1: module: define ksym_flags enumeration to represent kernel symbol flag=
s
> #2: module: add kflagstab section to vmlinux and modules
> #4: module: use kflagstab instead of *_gpl sections
> #6: module: deprecate usage of *_gpl sections
> #7: module: remove *_gpl sections from vmlinux and modules
>
> The changes look otherwise ok to me. With the above fixed, feel free to
> add:
>
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

Thanks a lot for the review. I incorporated the suggested changes and
sent the revised patch series for review.

Regards,
Siddharth Nayyar

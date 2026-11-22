Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795314478;
	b=VpGiOc+TryVR8KKsGSvZbgCDFWMQFKbhmfDURo1FksMFR7YIIw9/docIqYfWuy7yYRc8
	 wuw1ZfhbzR4UkqT62uHUbTpMbSLLNq3+rQbH1fgvdqPvDflbSoE8r8Cbo4sNawsqzKbeA
	 lYfU1XzpZFOLzTE9qVeTlMTE0GxkByIeJkVtqs0fZB3Kel8JhMC0yKsUd7pWajuLKoJZ+
	 Q5TbtutSPDDApNicbkIK/RE4mVmIIq7tjFkxDLn5aPOjSeA893DpD7MzEkcXTfM6/NARb
	 PRz6fpPz/jfabSYoEnhRLtzCxxho6kl/HgYulrNW6oxX3F4MGZg1rhtwVV+i7O1T59g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795314478;
	h=DMARC-Filter:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:X-HE-Tag:
	 X-HE-Meta;
	bh=4D2SPdXvFzhHtU/rKx2XeIymvmhTCDRiJ+HnEGRijwk=;
	b=A/wAYii1xhyfKiB4w76P+K9rGjI1/j+q3bzWJjDXFod9KrgT0U30entMeTpzqpEgDYUR
	 h4FkfBUInP5APBxUW6xe1+N++G1hAAypQA8UemvQB+Mjpg0nxTJOCQgRjw7dVxYkcu2nL
	 4W6tfyjDlJdl5wCEcbs/jSHNSVxnwS6GvcqE+v3UDAV0b1YvPcLIn1MoM67GhUXfiMQ/X
	 2o4gL/kOD1xIkl1y7TqXaNUmRSbmoTk3/v5e1dEcyyKonXpDKi55OJPzDKAQniOaRQoSy
	 OkviplfonBa2WVFCBJXRpqBX6xFJeIlgXn50N6npdYT93aRQ9X9zcqzg/MW0JvYZ2jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=perches.com;
	spf=pass smtp.mailfrom=perches.com;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7513606A320;
	Sun, 22 Nov 2026 02:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7513606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 667CE80616;
	Sun, 22 Nov 2026 02:27:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 26EE035;
	Sun, 22 Nov 2026 02:27:46 +0000 (UTC)
Message-ID: <a6fdcd6d4bce5ace3b4e34d1393f5cfe58e17c0d.camel@perches.com>
Subject: Re: [PATCH 6/6] checkpatch.pl: generalize linker script macro
 exceptions
From: Joe Perches <joe@perches.com>
To: jim.cromie@gmail.com, Arnd Bergmann <arnd@arndb.de>, Jason Baron	
 <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu	
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen	
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Andrew
 Morton	 <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org
Date: Sat, 21 Nov 2026 18:27:45 -0800
In-Reply-To: <20261121-vmlinux-lds-v1-6-49818f3f5cc0@gmail.com>
References: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
	 <20261121-vmlinux-lds-v1-6-49818f3f5cc0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 26EE035
X-Stat-Signature: w9zuxpnagi9dspiupreitz8xoeruuc7b
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19bfFqUuKiZmAtCFwr4IryfXNqQgCZjjIc=
X-HE-Tag: 1795314466-571539
X-HE-Meta: U2FsdGVkX1+TL4uTOyKpyV6pwBJ0urHG1vnQh3W3saL5ZFCEvzZASaRQhBGSEQeqk8C0XM4A3iHQc9oWMr4YTV3YtX4M7Vdj7l3eBxXIsWKok+ChOVdfvJ8xPEndkoJd7Py6oFVluYn1kKbak+nV5lsSwG+VZPHOQVGyB+FTL4bKCFTOmi93HdmalaQlMctudFb3neaIfTFg1RLsAnNUtf+MZZI9T493SUGB3fx2BnNLgcLwb8fJ9feZa0ONoaYPSlzWuVzrzFCiRR1EN9ZhaGhZ9xT6g81SU4MsQZgBC8m+xNSS2TuVWPAw5trzOU4/jfc7B3x8bzfUfdUQXx+Tojyt2BCtCWuC

On Sat, 2026-11-21 at 15:49 -0700, Jim Cromie via B4 Relay wrote:
> From: Jim Cromie <jim.cromie@gmail.com>
>=20
> checkpatch skips macro-rule checks in linker scripts; 3 of them
> explicitly check for vmlinux.lds.h, and 1 (the 1st) skips on any
> *.lds.h.  Generalize the 3 to match the 1st, including the escapes on
> the dots, so they're literal checks for '.'

Please remember to email the checkpatch maintainer too.

>=20
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  scripts/checkpatch.pl | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index b8b64f720191..318e1f2577fd 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6016,7 +6016,7 @@ sub process {
>  # Usually multi-statement macros should be enclosed in a do {} while
>  # (0) loop.  Grab the first statement and ensure its the whole macro
>  # if its not enclosed in a known good container
> -		if ($realfile !~ m@/vmlinux.lds.h$@ &&
> +		if ($realfile !~ m@/\.lds\.h$@ &&

Probably better to have something like
my $is_linker_file =3D '\.lds\.h$';
or maybe
my $is_linker_file =3D '\Q.lds.h\E$';

and use that everywhere

> @@ -6175,7 +6175,7 @@ sub process {
> =20
>  # check for line continuations outside of #defines, preprocessor #, and =
asm
> =20
> -		} elsif ($realfile =3D~ m@/vmlinux.lds.h$@) {
> +		} elsif ($realfile =3D~ m@/\.lds\.h$@) {

>  		    $line =3D~ s/(\w+)/$maybe_linker_symbol{$1}++/ge;
>  		    #print "REAL: $realfile\nln: $line\nkeys:", sort keys %maybe_linke=
r_symbol;
>  		} else {
> @@ -6192,7 +6192,7 @@ sub process {
>  # single-statement macros do not need to be enclosed in do while (0) loo=
p,
>  # macro should not end with a semicolon
>  		if ($perl_version_ok &&
> -		    $realfile !~ m@/vmlinux.lds.h$@ &&
> +		    $realfile !~ m@/\.lds\.h$@ &&
>  		    $line =3D~ /^.\s*\#\s*define\s+$Ident(\()?/) {
>  			my $ln =3D $linenr;
>  			my $cnt =3D $realcnt;

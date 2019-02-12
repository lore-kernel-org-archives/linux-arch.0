From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 05/28] x86/asm/entry: annotate THUNKs
Date: Tue, 12 Feb 2019 12:05:01 +0100
Message-ID: <20190212110501.GB30028@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-6-jslaby@suse.cz>
 <20190209112551.GA5089@zn.tnic>
 <b75f2a0d-974a-c63b-64f8-8f333991e826@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b75f2a0d-974a-c63b-64f8-8f333991e826@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 12, 2019 at 11:27:19AM +0100, Jiri Slaby wrote:
> Yes, they do not end up in the symbol table. But the macros make clear
> where is the start of the function and especially where is the end
> (something like closing bracket '}' in C). If you prefer not annotating
> local symbols, I can of course drop it from everywhere. But to me it
> looks more readable to see "here it starts" and "here it ends", still
> without generating anything to the symbol table.

Agreed. Boundary annotation makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

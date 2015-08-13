From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCHv4 man-pages 3/3] open.2: describe O_BENEATH flag
Date: Thu, 13 Aug 2015 10:38:20 -0700
Message-ID: <CALCETrWusE9CbQ6A1iqgBVjei-_JWL4o4ezS14JLEAbrGJmaNg@mail.gmail.com>
References: <1439458366-8223-1-git-send-email-drysdale@google.com> <1439458366-8223-4-git-send-email-drysdale@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36268 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbbHMRil (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Aug 2015 13:38:41 -0400
Received: by obnw1 with SMTP id w1so42454464obn.3
        for <linux-arch@vger.kernel.org>; Thu, 13 Aug 2015 10:38:40 -0700 (PDT)
In-Reply-To: <1439458366-8223-4-git-send-email-drysdale@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Drysdale <drysdale@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Meredydd Luff <meredydd@senatehouse.org>, Will Drewry <wad@chromium.org>, Jorge Lucangeli Obes <jorgelo@google.com>, Ricky Zhou <rickyz@google.com>, Lee Campbell <leecam@google.com>, Julien Tinnes <jln@google.com>, Mike Depinet <mdepinet@google.com>, James Morris <james.l.morris@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Paul Moore <paul@paul-moore.com>, Christoph Hellwig <hch@infradead.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Dave Chinner <david@fromorbit.com>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, Linux FS Devel <linux-fsdevel@>

On Thu, Aug 13, 2015 at 2:32 AM, David Drysdale <drysdale@google.com> wrote:
> Signed-off-by: David Drysdale <drysdale@google.com>

What's the behavior wrt fcntl(F_GETFL, etc)?

--Andy
